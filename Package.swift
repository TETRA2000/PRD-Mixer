// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "PRDMixerTools",
    platforms: [.macOS(.v26)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
    ],
    targets: [
        .executableTarget(
            name: "prompt-tuner",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: ".",
            exclude: [
                "PRD Mixer.xcodeproj",
                "PRD Mixer/Assets.xcassets",
                "PRD Mixer/ContentView.swift",
                "PRD Mixer/PRD_MixerApp.swift",
                "PRD Mixer/Extensions",
                "PRD Mixer/Services",
                "PRD Mixer/ViewModels",
                "PRD Mixer/Views",
                "PRD Mixer/Models/DiscoverItem.swift",
                "PRD Mixer/Models/Project.swift",
                "PRD Mixer/Data/DefaultDiscoverItems.swift",
                "PRD MixerTests",
                "PRD MixerUITests",
                "docs",
                "README.md",
                "CLAUDE.md",
                "PRD_Mixer.md",
            ],
            sources: [
                "PRD Mixer/Models/Ingredient.swift",
                "PRD Mixer/Models/IngredientCategory.swift",
                "PRD Mixer/Models/PromptPurpose.swift",
                "PRD Mixer/Models/SystemPrompt.swift",
                "PRD Mixer/Data/DefaultCategories.swift",
                "PRD Mixer/Data/DefaultIngredients.swift",
                "PRD Mixer/Data/DefaultSystemPrompts.swift",
                "PromptTuner/Sources/",
            ],
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
    ]
)
