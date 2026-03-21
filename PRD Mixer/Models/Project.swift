import Foundation
import SwiftData

@Model
final class Project {
    var projectId: UUID
    var title: String
    var createdAt: Date
    var updatedAt: Date
    var ingredientsData: Data
    var systemPromptBody: String
    var generatedPRD: String

    init(
        title: String,
        ingredients: [IngredientData],
        systemPromptBody: String,
        generatedPRD: String
    ) {
        self.projectId = UUID()
        self.title = title
        self.createdAt = Date()
        self.updatedAt = Date()
        self.ingredientsData = (try? JSONEncoder().encode(ingredients)) ?? Data()
        self.systemPromptBody = systemPromptBody
        self.generatedPRD = generatedPRD
    }

    var ingredients: [IngredientData] {
        get {
            (try? JSONDecoder().decode([IngredientData].self, from: ingredientsData)) ?? []
        }
        set {
            ingredientsData = (try? JSONEncoder().encode(newValue)) ?? Data()
            updatedAt = Date()
        }
    }

    var ingredientEmojis: String {
        ingredients.map(\.emoji).joined()
    }

    var wordCount: Int {
        generatedPRD.split(separator: " ").count
    }
}
