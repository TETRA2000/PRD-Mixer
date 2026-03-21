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
            id: "techStack",
            displayName: "Tech Stack",
            emoji: "\u{1F6E0}\u{FE0F}",
            colorHex: "#636E72",
            secondaryColorHex: "#B2BEC3",
            sortOrder: 5
        ),
        CategoryData(
            id: "monetisation",
            displayName: "Monetisation",
            emoji: "\u{1F4B0}",
            colorHex: "#FDCB6E",
            secondaryColorHex: "#FFEAA7",
            sortOrder: 6
        ),
        CategoryData(
            id: "scale",
            displayName: "Scale",
            emoji: "\u{1F4CF}",
            colorHex: "#00CEC9",
            secondaryColorHex: "#81ECEC",
            sortOrder: 7
        ),
    ]

    static func category(for id: String) -> CategoryData? {
        all.first { $0.id == id }
    }
}
