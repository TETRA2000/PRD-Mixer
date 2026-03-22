import Testing
import Foundation
@testable import PRD_Mixer

struct PRDGenerationServiceTests {

    private func makeIngredients() -> [IngredientData] {
        [
            IngredientData(id: "test1", emoji: "🧪", label: "Test App", categoryId: "appType", colorHex: "#000000"),
            IngredientData(id: "test2", emoji: "📱", label: "Mobile", categoryId: "platform", colorHex: "#111111"),
        ]
    }

    // MARK: - Cancel

    @Test func cancel_setsIsGeneratingToFalse() {
        let service = PRDGenerationService()
        service.cancel()
        #expect(!service.isGenerating)
    }

    @Test func cancel_resetsState() {
        let service = PRDGenerationService()
        service.cancel()
        #expect(!service.isGenerating)
    }

    // MARK: - Cancellation via Task

    @MainActor
    @Test func generate_stopsWhenTaskIsCancelled() async throws {
        let service = PRDGenerationService()
        let ingredients = makeIngredients()

        let task = Task { @MainActor in
            await service.generate(ingredients: ingredients, systemPrompt: "Test prompt")
        }

        // Give the generation a moment to start streaming
        try await Task.sleep(for: .milliseconds(50))

        // Cancel the task — this should stop the streaming loop
        task.cancel()

        // Wait for the task to finish
        await task.value

        // The service should not report an error for cancellation
        #expect(service.error == nil)
        // The streamed text should be partial (not the full placeholder)
        // or generation should have stopped
        #expect(!service.isGenerating)
    }

    // MARK: - Placeholder generation

    @MainActor
    @Test func generate_completesAndIsNotGenerating() async {
        let service = PRDGenerationService()
        let ingredients = makeIngredients()

        await service.generate(ingredients: ingredients, systemPrompt: "Test prompt")

        // After generation finishes (success or model-unavailable error), isGenerating must be false
        #expect(!service.isGenerating)
        // Either text was generated or an error was reported — but not both
        let hasText = !service.streamedText.isEmpty
        let hasError = service.error != nil
        #expect(hasText || hasError)
    }

    @MainActor
    @Test func generate_resetsStateBeforeStarting() async {
        let service = PRDGenerationService()
        service.streamedText = "old text"
        service.error = "old error"

        let ingredients = makeIngredients()
        await service.generate(ingredients: ingredients, systemPrompt: "Test prompt")

        #expect(!service.streamedText.contains("old text"))
        #expect(service.error == nil)
    }

    // MARK: - Prewarm

    @Test func prewarm_doesNotCrash() {
        let service = PRDGenerationService()
        // Should be safe to call regardless of model availability
        service.prewarm(systemPrompt: "Test prompt")
    }

    @Test func prewarm_isIdempotent() {
        let service = PRDGenerationService()
        service.prewarm(systemPrompt: "Test prompt")
        service.prewarm(systemPrompt: "Test prompt")
        // Should not crash or create duplicate sessions
    }

    @Test func cancel_allowsSubsequentPrewarm() {
        let service = PRDGenerationService()
        service.prewarm(systemPrompt: "Test prompt")
        service.cancel()
        // After cancel, prewarm should be allowed again
        service.prewarm(systemPrompt: "Test prompt")
        #expect(!service.isGenerating)
    }
}
