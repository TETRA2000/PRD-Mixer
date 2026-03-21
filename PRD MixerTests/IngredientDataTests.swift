import Testing
import Foundation
@testable import PRD_Mixer

struct IngredientDataTests {

    // MARK: - Initialization

    @Test func defaultInit_setsExpectedDefaults() {
        let ingredient = IngredientData(
            emoji: "🎉",
            label: "Party App",
            categoryId: "appType",
            colorHex: "#FF0000"
        )
        #expect(!ingredient.id.isEmpty)
        #expect(ingredient.emoji == "🎉")
        #expect(ingredient.label == "Party App")
        #expect(ingredient.categoryId == "appType")
        #expect(ingredient.colorHex == "#FF0000")
        #expect(ingredient.isCustom == false)
        #expect(ingredient.isFromSuggestion == false)
    }

    @Test func initWithCustomFlags() {
        let ingredient = IngredientData(
            id: "custom_1",
            emoji: "🔥",
            label: "Hot Feature",
            categoryId: "feature",
            colorHex: "#E17055",
            isCustom: true,
            isFromSuggestion: true
        )
        #expect(ingredient.id == "custom_1")
        #expect(ingredient.isCustom == true)
        #expect(ingredient.isFromSuggestion == true)
    }

    // MARK: - Codable

    @Test func encodeDecode_roundTrips() throws {
        let original = IngredientData(
            id: "test_1",
            emoji: "📱",
            label: "iOS",
            categoryId: "platform",
            colorHex: "#0984E3"
        )
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(IngredientData.self, from: data)
        #expect(decoded == original)
    }

    @Test func encodeDecodeArray_roundTrips() throws {
        let ingredients = [
            IngredientData(id: "a", emoji: "🐱", label: "Cats", categoryId: "theme", colorHex: "#FDCB6E"),
            IngredientData(id: "b", emoji: "🐶", label: "Dogs", categoryId: "theme", colorHex: "#E17055"),
        ]
        let data = try JSONEncoder().encode(ingredients)
        let decoded = try JSONDecoder().decode([IngredientData].self, from: data)
        #expect(decoded == ingredients)
    }

    // MARK: - Hashable / Equatable

    @Test func equality_basedOnAllProperties() {
        let a = IngredientData(id: "x", emoji: "🎮", label: "Gaming", categoryId: "theme", colorHex: "#A29BFE")
        let b = IngredientData(id: "x", emoji: "🎮", label: "Gaming", categoryId: "theme", colorHex: "#A29BFE")
        #expect(a == b)
    }

    @Test func inequality_differentId() {
        let a = IngredientData(id: "x", emoji: "🎮", label: "Gaming", categoryId: "theme", colorHex: "#A29BFE")
        let b = IngredientData(id: "y", emoji: "🎮", label: "Gaming", categoryId: "theme", colorHex: "#A29BFE")
        #expect(a != b)
    }
}
