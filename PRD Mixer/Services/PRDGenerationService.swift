import Foundation
import SwiftUI

#if canImport(FoundationModels)
import FoundationModels
#endif

@Observable
final class PRDGenerationService {
    static let userPromptPrefix = "Generate a PRD for an app with these ingredients:"

    var isGenerating = false
    var streamedText = ""
    var error: String?

    #if canImport(FoundationModels)
    private var session: LanguageModelSession?
    private var isPrewarmed = false
    private var prewarmedSystemPrompt: String?
    #endif

    var isAvailable: Bool {
        #if canImport(FoundationModels)
        SystemLanguageModel.default.availability == .available
        #else
        false
        #endif
    }

    /// Returns a user-friendly message explaining why Apple Intelligence is not available,
    /// or `nil` if it is available.
    var unavailabilityMessage: String? {
        #if canImport(FoundationModels)
        switch SystemLanguageModel.default.availability {
        case .available:
            return nil
        case .unavailable(let reason):
            switch reason {
            case .deviceNotEligible:
                return "This device does not support Apple Intelligence. An iPhone 15 Pro or later, or an iPad or Mac with an M1 chip or later, is required."
            case .appleIntelligenceNotEnabled:
                return "Apple Intelligence is not enabled. Please enable it in Settings > Apple Intelligence & Siri to use this app's features."
            case .modelNotReady:
                return "Apple Intelligence is still setting up. Please wait for the download to complete in Settings > Apple Intelligence & Siri, then try again."
            @unknown default:
                return "Apple Intelligence is currently unavailable on this device. Please check Settings > Apple Intelligence & Siri."
            }
        @unknown default:
            return "Apple Intelligence is currently unavailable on this device. Please check Settings > Apple Intelligence & Siri."
        }
        #else
        return "Apple Intelligence is not available in the simulator."
        #endif
    }

    // MARK: - Prewarming

    /// Creates a session and preloads model resources so generation starts faster.
    /// Call this when the user begins selecting ingredients to give the system
    /// a head start before they tap "Mix".
    func prewarm(systemPrompt: String) {
        #if canImport(FoundationModels)
        guard !isPrewarmed,
              SystemLanguageModel.default.availability == .available else { return }

        let session = LanguageModelSession(instructions: systemPrompt)
        self.session = session
        prewarmedSystemPrompt = systemPrompt

        // Cache the known prompt prefix so the model can process it eagerly
        let promptPrefix = Prompt(Self.userPromptPrefix)
        session.prewarm(promptPrefix: promptPrefix)
        isPrewarmed = true
        #endif
    }

    // MARK: - Generation

    @MainActor
    func generate(ingredients: [IngredientData], systemPrompt: String) async {
        isGenerating = true
        streamedText = ""
        error = nil

        #if canImport(FoundationModels)
        guard SystemLanguageModel.default.availability == .available else {
            error = unavailabilityMessage ?? "Apple Intelligence is currently unavailable on this device."
            isGenerating = false
            return
        }

        // Reuse a prewarmed session if the system prompt matches, otherwise create a new one
        let session: LanguageModelSession
        if let existing = self.session, prewarmedSystemPrompt == systemPrompt {
            session = existing
        } else {
            session = LanguageModelSession(instructions: systemPrompt)
            self.session = session
        }

        let ingredientList = ingredients
            .map { "\($0.emoji) \($0.label) (Category: \($0.categoryId))" }
            .joined(separator: "\n")

        let userPrompt = """
        \(Self.userPromptPrefix)

        \(ingredientList)

        Create a detailed, well-structured Product Requirements Document in Markdown format.
        """

        do {
            let stream = session.streamResponse(to: userPrompt)
            for try await partial in stream {
                try Task.checkCancellation()
                streamedText = partial.content
            }
        } catch is CancellationError {
            // Task was cancelled (e.g. user dismissed the view) — not an error
            self.session = nil
        } catch {
            self.error = "Generation failed: \(error.localizedDescription)"
        }
        #else
        // Simulator fallback: generate a placeholder PRD
        do {
            try await generatePlaceholder(ingredients: ingredients)
        } catch is CancellationError {
            // Task was cancelled — not an error
        } catch {
            self.error = "Generation failed: \(error.localizedDescription)"
        }
        #endif

        isGenerating = false
    }

    func cancel() {
        #if canImport(FoundationModels)
        session = nil
        isPrewarmed = false
        prewarmedSystemPrompt = nil
        #endif
        isGenerating = false
    }

    // MARK: - Simulator Placeholder

    @MainActor
    private func generatePlaceholder(ingredients: [IngredientData]) async throws {
        let ingredientList = ingredients
            .map { "- \($0.emoji) **\($0.label)**" }
            .joined(separator: "\n")

        let title = ingredients.first?.label ?? "Untitled App"

        let placeholder = """
        # \(title) — Product Requirements Document

        > *Generated by PRD Mixer*

        ## Executive Summary

        This PRD defines a product concept built from the following ingredients. \
        The app combines these elements into a cohesive product vision.

        ## Selected Ingredients

        \(ingredientList)

        ## Problem Statement

        Users need a solution that brings together \(ingredients.map(\.label).joined(separator: ", ")). \
        Existing solutions fail to address this specific combination of needs.

        ## Target Audience

        This app targets users who value the combination of capabilities described by the selected ingredients.

        ## Core Features

        \(ingredients.filter { $0.categoryId == "feature" || $0.categoryId == "appType" }.map { "- \($0.emoji) **\($0.label)**: Core functionality derived from this ingredient." }.joined(separator: "\n"))

        ## Non-Functional Requirements

        - Performance: 60fps UI, sub-2-second generation
        - Privacy: On-device processing where possible
        - Accessibility: Full VoiceOver support, Dynamic Type
        - Offline: Core features work without network

        ## Technical Architecture

        \(ingredients.filter { $0.categoryId == "interactionModel" || $0.categoryId == "platform" }.map { "- \($0.emoji) **\($0.label)**" }.joined(separator: "\n"))

        ## Milestones

        ### Phase 1 — MVP
        - Core feature implementation
        - Basic UI and navigation

        ### Phase 2 — Enhancement
        - Polish and additional features
        - User feedback integration

        ### Phase 3 — Growth
        - Community features
        - Advanced capabilities

        ---

        *Note: This is a placeholder PRD generated in simulator mode. \
        On a real device with iOS 26+, the Foundation Model will generate a fully detailed PRD.*
        """

        // Simulate streaming by revealing text character by character in chunks
        let characters = Array(placeholder)
        var current = ""
        var i = 0
        while i < characters.count {
            try Task.checkCancellation()
            // Advance by a small chunk (roughly one word) to simulate token streaming
            let chunkEnd = min(i + 6, characters.count)
            current += String(characters[i..<chunkEnd])
            streamedText = current
            i = chunkEnd
            try? await Task.sleep(for: .milliseconds(15))
        }
    }
}
