import Testing
import Foundation
import SwiftData
@testable import PRD_Mixer

struct SettingsViewModelTests {

    private func makeContext() throws -> ModelContext {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: SystemPrompt.self,
            configurations: config
        )
        return ModelContext(container)
    }

    @Test func seedDefaultPrompts_createsThreeDefaults() throws {
        let context = try makeContext()
        let vm = SettingsViewModel()

        vm.seedDefaultPrompts(modelContext: context)

        let all = try context.fetch(FetchDescriptor<SystemPrompt>())
        #expect(all.count == 3)
        #expect(all.allSatisfy { $0.isDefault })
    }

    @Test func seedDefaultPrompts_doesNotDuplicateOnSecondCall() throws {
        let context = try makeContext()
        let vm = SettingsViewModel()

        vm.seedDefaultPrompts(modelContext: context)
        vm.seedDefaultPrompts(modelContext: context)

        let all = try context.fetch(FetchDescriptor<SystemPrompt>())
        #expect(all.count == 3)
    }

    @Test func resetToDefaultPrompts_removesCustomPrompts() throws {
        let context = try makeContext()
        let vm = SettingsViewModel()

        vm.seedDefaultPrompts(modelContext: context)

        // Add a custom prompt
        let custom = SystemPrompt(
            name: "My Custom",
            body: "Custom body",
            purpose: .generation,
            isDefault: false
        )
        context.insert(custom)
        try context.save()

        let beforeReset = try context.fetch(FetchDescriptor<SystemPrompt>())
        #expect(beforeReset.count == 4)

        vm.resetToDefaultPrompts(modelContext: context)

        let afterReset = try context.fetch(FetchDescriptor<SystemPrompt>())
        #expect(afterReset.count == 3)
        #expect(afterReset.allSatisfy { $0.isDefault })
    }

    @Test func resetToDefaultPrompts_restoresModifiedDefaults() throws {
        let context = try makeContext()
        let vm = SettingsViewModel()

        vm.seedDefaultPrompts(modelContext: context)

        // Modify a default prompt
        let all = try context.fetch(FetchDescriptor<SystemPrompt>())
        let genPrompt = all.first { $0.purpose == .generation }!
        genPrompt.body = "Modified body"
        try context.save()

        vm.resetToDefaultPrompts(modelContext: context)

        let afterReset = try context.fetch(FetchDescriptor<SystemPrompt>())
        let restored = afterReset.first { $0.purpose == .generation }!
        #expect(restored.body == DefaultSystemPrompts.generationPromptBody)
    }

    @Test func resetToDefaultPrompts_worksWhenEmpty() throws {
        let context = try makeContext()
        let vm = SettingsViewModel()

        vm.resetToDefaultPrompts(modelContext: context)

        let all = try context.fetch(FetchDescriptor<SystemPrompt>())
        #expect(all.count == 3)
        #expect(all.allSatisfy { $0.isDefault })
    }
}
