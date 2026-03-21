import Testing
import Foundation
@testable import PRD_Mixer

struct ProjectTests {

    private func sampleIngredients() -> [IngredientData] {
        [
            IngredientData(id: "a", emoji: "📝", label: "TODO List", categoryId: "appType", colorHex: "#6C5CE7"),
            IngredientData(id: "b", emoji: "📱", label: "iOS", categoryId: "platform", colorHex: "#0984E3"),
        ]
    }

    @Test func init_setsAllProperties() {
        let ingredients = sampleIngredients()
        let project = Project(
            title: "Test PRD",
            ingredients: ingredients,
            systemPromptBody: "You are a PRD generator.",
            generatedPRD: "# Test\n\nHello world content here"
        )

        #expect(project.title == "Test PRD")
        #expect(project.systemPromptBody == "You are a PRD generator.")
        #expect(project.generatedPRD == "# Test\n\nHello world content here")
        #expect(project.createdAt <= Date())
        #expect(project.updatedAt <= Date())
    }

    @Test func ingredients_roundTrips() {
        let ingredients = sampleIngredients()
        let project = Project(
            title: "Test",
            ingredients: ingredients,
            systemPromptBody: "",
            generatedPRD: ""
        )

        #expect(project.ingredients.count == 2)
        #expect(project.ingredients[0].id == "a")
        #expect(project.ingredients[1].id == "b")
    }

    @Test func ingredients_setter_updatesData() {
        let project = Project(
            title: "Test",
            ingredients: sampleIngredients(),
            systemPromptBody: "",
            generatedPRD: ""
        )
        let originalDate = project.updatedAt

        // Small delay to ensure updatedAt changes
        let newIngredients = [
            IngredientData(id: "c", emoji: "🐱", label: "Cats", categoryId: "theme", colorHex: "#FDCB6E"),
        ]
        project.ingredients = newIngredients

        #expect(project.ingredients.count == 1)
        #expect(project.ingredients[0].id == "c")
        #expect(project.updatedAt >= originalDate)
    }

    @Test func ingredientEmojis_returnsJoinedEmojis() {
        let project = Project(
            title: "Test",
            ingredients: sampleIngredients(),
            systemPromptBody: "",
            generatedPRD: ""
        )
        #expect(project.ingredientEmojis == "📝📱")
    }

    @Test func wordCount_countsWords() {
        let project = Project(
            title: "Test",
            ingredients: [],
            systemPromptBody: "",
            generatedPRD: "This is a test document"
        )
        #expect(project.wordCount == 5)

        let project2 = Project(
            title: "Test",
            ingredients: [],
            systemPromptBody: "",
            generatedPRD: ""
        )
        #expect(project2.wordCount == 0)
    }

    @Test func emptyIngredients_returnsEmptyArray() {
        let project = Project(
            title: "Test",
            ingredients: [],
            systemPromptBody: "",
            generatedPRD: ""
        )
        #expect(project.ingredients.isEmpty)
        #expect(project.ingredientEmojis == "")
    }
}
