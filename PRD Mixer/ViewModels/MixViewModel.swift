import Foundation
import SwiftData
import SwiftUI

@Observable
final class MixViewModel {
    var selectedIngredients: [IngredientData] = []
    var isShowingGeneration = false
    var projectTitle = ""

    let generationService = PRDGenerationService()

    // MARK: - Category & Ingredient Access

    func allCategories(customCategories: [CustomCategory]) -> [CategoryData] {
        let defaults = DefaultCategories.all
        let custom = customCategories.map { CategoryData(from: $0) }
        return (defaults + custom).sorted { $0.sortOrder < $1.sortOrder }
    }

    func ingredients(for categoryId: String, customIngredients: [CustomIngredient]) -> [IngredientData] {
        let defaults = DefaultIngredients.ingredients(for: categoryId)
        let custom = customIngredients
            .filter { $0.categoryId == categoryId }
            .map { IngredientData(from: $0) }
        return defaults + custom
    }

    // MARK: - Selection

    func toggleIngredient(_ ingredient: IngredientData) {
        if let index = selectedIngredients.firstIndex(where: { $0.id == ingredient.id }) {
            selectedIngredients.remove(at: index)
            HapticService.remove()
        } else {
            selectedIngredients.append(ingredient)
            HapticService.selection()

            // Prewarm the Foundation Model on first selection so generation starts faster
            if selectedIngredients.count == 1 {
                generationService.prewarm(systemPrompt: DefaultSystemPrompts.generationPromptBody)
            }
        }
    }

    func isSelected(_ ingredient: IngredientData) -> Bool {
        selectedIngredients.contains { $0.id == ingredient.id }
    }

    var selectedCount: Int {
        selectedIngredients.count
    }

    func clearSelection() {
        selectedIngredients.removeAll()
        generationService.cancel()
    }

    // MARK: - Generation

    func mix(systemPrompt: String) async {
        HapticService.mixStart()
        await generationService.generate(
            ingredients: selectedIngredients,
            systemPrompt: systemPrompt
        )
        if generationService.error == nil {
            HapticService.mixComplete()
        } else {
            HapticService.error()
        }
    }

    // MARK: - Save Project

    func saveProject(modelContext: ModelContext) {
        let title = projectTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let finalTitle = title.isEmpty ? generatedTitle : title

        let project = Project(
            title: finalTitle,
            ingredients: selectedIngredients,
            systemPromptBody: DefaultSystemPrompts.generationPromptBody,
            generatedPRD: generationService.streamedText
        )
        modelContext.insert(project)
        try? modelContext.save()
    }

    var generatedTitle: String {
        // Extract the title from the first Markdown heading in the generated PRD
        let text = generationService.streamedText
        if !text.isEmpty {
            let lines = text.components(separatedBy: .newlines)
            for line in lines {
                let trimmed = line.trimmingCharacters(in: .whitespaces)
                if trimmed.hasPrefix("# ") {
                    let title = String(trimmed.dropFirst(2)).trimmingCharacters(in: .whitespaces)
                    if !title.isEmpty {
                        return title
                    }
                }
            }
        }
        // Fallback to ingredient-based title
        let labels = selectedIngredients.prefix(3).map(\.label)
        if labels.isEmpty { return "Untitled PRD" }
        return labels.joined(separator: " + ")
    }

    // MARK: - Surprise Me

    func surpriseMe(customCategories: [CustomCategory], customIngredients: [CustomIngredient]) {
        clearSelection()
        let categories = allCategories(customCategories: customCategories)
        let count = Int.random(in: 3...min(6, categories.count))
        let picked = Array(categories.shuffled().prefix(count))
        for category in picked {
            let available = ingredients(for: category.id, customIngredients: customIngredients)
            if let random = available.randomElement() {
                selectedIngredients.append(random)
            }
        }
        HapticService.selection()

        // Prewarm after random selection so generation starts faster
        if !selectedIngredients.isEmpty {
            generationService.prewarm(systemPrompt: DefaultSystemPrompts.generationPromptBody)
        }
    }

    // MARK: - Remix

    func loadIngredients(_ ingredients: [IngredientData]) {
        selectedIngredients = ingredients
    }
}
