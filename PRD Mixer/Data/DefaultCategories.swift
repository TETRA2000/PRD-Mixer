import Foundation

enum DefaultCategories {
    static let all: [CategoryData] = [
        CategoryData(
            id: "appType",
            displayName: "App Type",
            emoji: "\u{1F9E9}",
            colorHex: "#6C5CE7",
            secondaryColorHex: "#A29BFE",
            sortOrder: 0
        ),
        CategoryData(
            id: "platform",
            displayName: "Platform",
            emoji: "\u{1F4F1}",
            colorHex: "#0984E3",
            secondaryColorHex: "#74B9FF",
            sortOrder: 1
        ),
        CategoryData(
            id: "theme",
            displayName: "Theme / Audience",
            emoji: "\u{1F3AD}",
            colorHex: "#E17055",
            secondaryColorHex: "#FAB1A0",
            sortOrder: 2
        ),
        CategoryData(
            id: "uxStyle",
            displayName: "UX Style",
            emoji: "\u{1F3A8}",
            colorHex: "#E84393",
            secondaryColorHex: "#FD79A8",
            sortOrder: 3
        ),
        CategoryData(
            id: "feature",
            displayName: "Feature",
            emoji: "\u{26A1}",
            colorHex: "#00B894",
            secondaryColorHex: "#55EFC4",
            sortOrder: 4
        ),
        CategoryData(
            id: "interactionModel",
            displayName: "Interaction Model",
            emoji: "\u{1F91B}",
            colorHex: "#636E72",
            secondaryColorHex: "#B2BEC3",
            sortOrder: 5
        ),
        CategoryData(
            id: "vibe",
            displayName: "Vibe / Spirit",
            emoji: "\u{1FA84}",
            colorHex: "#FDCB6E",
            secondaryColorHex: "#FFEAA7",
            sortOrder: 6
        ),
        CategoryData(
            id: "gameGenre",
            displayName: "Game Genre",
            emoji: "\u{1F3AE}",
            colorHex: "#E74C3C",
            secondaryColorHex: "#FF6B6B",
            sortOrder: 7
        ),
        CategoryData(
            id: "creativeTool",
            displayName: "Creative Tool",
            emoji: "\u{1F58C}\u{FE0F}",
            colorHex: "#8E44AD",
            secondaryColorHex: "#BB6BD9",
            sortOrder: 8
        ),
        CategoryData(
            id: "world",
            displayName: "World / Setting",
            emoji: "\u{1F30D}",
            colorHex: "#27AE60",
            secondaryColorHex: "#6BCB77",
            sortOrder: 9
        ),
        CategoryData(
            id: "hobby",
            displayName: "Hobby",
            emoji: "\u{1F9F6}",
            colorHex: "#F39C12",
            secondaryColorHex: "#F7DC6F",
            sortOrder: 10
        ),
        CategoryData(
            id: "companion",
            displayName: "Companion / Sidekick",
            emoji: "\u{1F916}",
            colorHex: "#1ABC9C",
            secondaryColorHex: "#76D7C4",
            sortOrder: 11
        ),
        CategoryData(
            id: "popCulture",
            displayName: "Pop Culture Flavor",
            emoji: "\u{1F3AC}",
            colorHex: "#E91E63",
            secondaryColorHex: "#F48FB1",
            sortOrder: 12
        ),
        CategoryData(
            id: "transport",
            displayName: "Transportation",
            emoji: "\u{1F6B2}",
            colorHex: "#3498DB",
            secondaryColorHex: "#85C1E9",
            sortOrder: 13
        ),
    ]

    static func category(for id: String) -> CategoryData? {
        all.first { $0.id == id }
    }
}
