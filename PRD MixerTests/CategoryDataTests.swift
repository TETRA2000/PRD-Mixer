import Testing
import Foundation
@testable import PRD_Mixer

struct CategoryDataTests {

    @Test func defaultInit_setsIsDefaultTrue() {
        let category = CategoryData(
            id: "test",
            displayName: "Test",
            emoji: "🧪",
            colorHex: "#000000",
            secondaryColorHex: "#FFFFFF",
            sortOrder: 0
        )
        #expect(category.isDefault == true)
    }

    @Test func explicitIsDefault_false() {
        let category = CategoryData(
            id: "custom",
            displayName: "Custom",
            emoji: "✨",
            colorHex: "#000000",
            secondaryColorHex: "#FFFFFF",
            sortOrder: 10,
            isDefault: false
        )
        #expect(category.isDefault == false)
    }

    // MARK: - Codable

    @Test func encodeDecode_roundTrips() throws {
        let original = CategoryData(
            id: "appType",
            displayName: "App Type",
            emoji: "🧩",
            colorHex: "#6C5CE7",
            secondaryColorHex: "#A29BFE",
            sortOrder: 0
        )
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(CategoryData.self, from: data)
        #expect(decoded == original)
    }
}
