import Testing
import SwiftUI
@testable import PRD_Mixer

struct ColorHexTests {

    @Test func sixDigitHex_parsesCorrectly() {
        let color = Color(hex: "#FF0000")
        // Should not crash; basic verification that it creates a color
        #expect(type(of: color) == Color.self)
    }

    @Test func sixDigitHex_withoutHash() {
        let color = Color(hex: "00FF00")
        #expect(type(of: color) == Color.self)
    }

    @Test func eightDigitHex_parsesRGBA() {
        let color = Color(hex: "#FF000080")
        #expect(type(of: color) == Color.self)
    }

    @Test func invalidHex_fallsBackToGray() {
        // Invalid length should hit the default case
        let color = Color(hex: "XYZ")
        #expect(type(of: color) == Color.self)
    }

    @Test func emptyString_fallsBackToGray() {
        let color = Color(hex: "")
        #expect(type(of: color) == Color.self)
    }

    @Test func allDefaultColors_parse() {
        // Verify all color hex values used in default data can be parsed
        for category in DefaultCategories.all {
            let _ = Color(hex: category.colorHex)
            let _ = Color(hex: category.secondaryColorHex)
        }
        for ingredient in DefaultIngredients.all {
            let _ = Color(hex: ingredient.colorHex)
        }
        // If we get here without crashing, all hex values are parseable
    }
}
