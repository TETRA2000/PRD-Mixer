import Foundation

enum DefaultIngredients {
    static let all: [IngredientData] = appType + platform + theme + uxStyle + feature + techStack + monetisation + scale

    static func ingredients(for categoryId: String) -> [IngredientData] {
        all.filter { $0.categoryId == categoryId }
    }

    // MARK: - App Type (10)

    static let appType: [IngredientData] = [
        IngredientData(id: "appType_todo", emoji: "\u{1F4DD}", label: "TODO List", categoryId: "appType", colorHex: "#6C5CE7"),
        IngredientData(id: "appType_chat", emoji: "\u{1F4AC}", label: "Chat App", categoryId: "appType", colorHex: "#0984E3"),
        IngredientData(id: "appType_fitness", emoji: "\u{1F3CB}\u{FE0F}", label: "Fitness Tracker", categoryId: "appType", colorHex: "#E17055"),
        IngredientData(id: "appType_ecommerce", emoji: "\u{1F6D2}", label: "E-commerce", categoryId: "appType", colorHex: "#00B894"),
        IngredientData(id: "appType_journal", emoji: "\u{1F4D3}", label: "Journal", categoryId: "appType", colorHex: "#FDCB6E"),
        IngredientData(id: "appType_weather", emoji: "\u{1F324}\u{FE0F}", label: "Weather", categoryId: "appType", colorHex: "#74B9FF"),
        IngredientData(id: "appType_photo", emoji: "\u{1F4F8}", label: "Photo App", categoryId: "appType", colorHex: "#E84393"),
        IngredientData(id: "appType_music", emoji: "\u{1F3B5}", label: "Music Player", categoryId: "appType", colorHex: "#A29BFE"),
        IngredientData(id: "appType_reading", emoji: "\u{1F4DA}", label: "Reading App", categoryId: "appType", colorHex: "#D63031"),
        IngredientData(id: "appType_travel", emoji: "\u{1F5FA}\u{FE0F}", label: "Travel Guide", categoryId: "appType", colorHex: "#00CEC9"),
    ]

    // MARK: - Platform (7)

    static let platform: [IngredientData] = [
        IngredientData(id: "platform_ios", emoji: "\u{1F4F1}", label: "iOS", categoryId: "platform", colorHex: "#0984E3"),
        IngredientData(id: "platform_ipados", emoji: "\u{1F4F2}", label: "iPadOS", categoryId: "platform", colorHex: "#6C5CE7"),
        IngredientData(id: "platform_macos", emoji: "\u{1F4BB}", label: "macOS", categoryId: "platform", colorHex: "#2D3436"),
        IngredientData(id: "platform_watchos", emoji: "\u{231A}", label: "watchOS", categoryId: "platform", colorHex: "#E17055"),
        IngredientData(id: "platform_visionos", emoji: "\u{1F97D}", label: "visionOS", categoryId: "platform", colorHex: "#A29BFE"),
        IngredientData(id: "platform_web", emoji: "\u{1F310}", label: "Web", categoryId: "platform", colorHex: "#00B894"),
        IngredientData(id: "platform_android", emoji: "\u{1F916}", label: "Android", categoryId: "platform", colorHex: "#00CEC9"),
    ]

    // MARK: - Theme / Audience (12)

    static let theme: [IngredientData] = [
        IngredientData(id: "theme_cats", emoji: "\u{1F431}", label: "Cats", categoryId: "theme", colorHex: "#FDCB6E"),
        IngredientData(id: "theme_dogs", emoji: "\u{1F436}", label: "Dogs", categoryId: "theme", colorHex: "#E17055"),
        IngredientData(id: "theme_kids", emoji: "\u{1F476}", label: "Kids", categoryId: "theme", colorHex: "#FF7675"),
        IngredientData(id: "theme_seniors", emoji: "\u{1F474}", label: "Seniors", categoryId: "theme", colorHex: "#74B9FF"),
        IngredientData(id: "theme_students", emoji: "\u{1F393}", label: "Students", categoryId: "theme", colorHex: "#6C5CE7"),
        IngredientData(id: "theme_cooking", emoji: "\u{1F373}", label: "Cooking", categoryId: "theme", colorHex: "#E17055"),
        IngredientData(id: "theme_travel", emoji: "\u{2708}\u{FE0F}", label: "Travel", categoryId: "theme", colorHex: "#00CEC9"),
        IngredientData(id: "theme_health", emoji: "\u{1F4AA}", label: "Health & Wellness", categoryId: "theme", colorHex: "#00B894"),
        IngredientData(id: "theme_gaming", emoji: "\u{1F3AE}", label: "Gaming", categoryId: "theme", colorHex: "#A29BFE"),
        IngredientData(id: "theme_business", emoji: "\u{1F3E2}", label: "Business", categoryId: "theme", colorHex: "#2D3436"),
        IngredientData(id: "theme_sustainability", emoji: "\u{1F33F}", label: "Sustainability", categoryId: "theme", colorHex: "#00B894"),
        IngredientData(id: "theme_creative", emoji: "\u{1F3A8}", label: "Creative Arts", categoryId: "theme", colorHex: "#E84393"),
    ]

    // MARK: - UX Style (10)

    static let uxStyle: [IngredientData] = [
        IngredientData(id: "ux_minimalist", emoji: "\u{2728}", label: "Minimalist", categoryId: "uxStyle", colorHex: "#DFE6E9"),
        IngredientData(id: "ux_playful", emoji: "\u{1F3A8}", label: "Playful", categoryId: "uxStyle", colorHex: "#FF7675"),
        IngredientData(id: "ux_skeuomorphic", emoji: "\u{1F3D7}\u{FE0F}", label: "Skeuomorphic", categoryId: "uxStyle", colorHex: "#FDCB6E"),
        IngredientData(id: "ux_brutalist", emoji: "\u{1F9F1}", label: "Brutalist", categoryId: "uxStyle", colorHex: "#2D3436"),
        IngredientData(id: "ux_glassmorphism", emoji: "\u{1FA9F}", label: "Glassmorphism", categoryId: "uxStyle", colorHex: "#74B9FF"),
        IngredientData(id: "ux_colorful", emoji: "\u{1F308}", label: "Colorful", categoryId: "uxStyle", colorHex: "#E84393"),
        IngredientData(id: "ux_darkmode", emoji: "\u{1F5A4}", label: "Dark Mode First", categoryId: "uxStyle", colorHex: "#2D3436"),
        IngredientData(id: "ux_grid", emoji: "\u{1F4D0}", label: "Grid-Based", categoryId: "uxStyle", colorHex: "#0984E3"),
        IngredientData(id: "ux_fluid", emoji: "\u{1FAE7}", label: "Fluid / Organic", categoryId: "uxStyle", colorHex: "#A29BFE"),
        IngredientData(id: "ux_dashboard", emoji: "\u{1F3AF}", label: "Dashboard", categoryId: "uxStyle", colorHex: "#00B894"),
    ]

    // MARK: - Feature (15)

    static let feature: [IngredientData] = [
        IngredientData(id: "feat_push", emoji: "\u{1F514}", label: "Push Notifications", categoryId: "feature", colorHex: "#E17055"),
        IngredientData(id: "feat_iap", emoji: "\u{1F4B3}", label: "In-App Purchase", categoryId: "feature", colorHex: "#FDCB6E"),
        IngredientData(id: "feat_offline", emoji: "\u{1F4F4}", label: "Offline Mode", categoryId: "feature", colorHex: "#636E72"),
        IngredientData(id: "feat_widgets", emoji: "\u{1F4E6}", label: "Widgets", categoryId: "feature", colorHex: "#6C5CE7"),
        IngredientData(id: "feat_shortcuts", emoji: "\u{2328}\u{FE0F}", label: "Shortcuts", categoryId: "feature", colorHex: "#0984E3"),
        IngredientData(id: "feat_search", emoji: "\u{1F50D}", label: "Search", categoryId: "feature", colorHex: "#74B9FF"),
        IngredientData(id: "feat_voice", emoji: "\u{1F5E3}\u{FE0F}", label: "Voice Input", categoryId: "feature", colorHex: "#00CEC9"),
        IngredientData(id: "feat_analytics", emoji: "\u{1F4CA}", label: "Analytics Dashboard", categoryId: "feature", colorHex: "#00B894"),
        IngredientData(id: "feat_auth", emoji: "\u{1F510}", label: "Authentication", categoryId: "feature", colorHex: "#D63031"),
        IngredientData(id: "feat_location", emoji: "\u{1F4CD}", label: "Location Services", categoryId: "feature", colorHex: "#E84393"),
        IngredientData(id: "feat_camera", emoji: "\u{1F4F7}", label: "Camera Integration", categoryId: "feature", colorHex: "#A29BFE"),
        IngredientData(id: "feat_social", emoji: "\u{1F91D}", label: "Social Sharing", categoryId: "feature", colorHex: "#0984E3"),
        IngredientData(id: "feat_sync", emoji: "\u{1F504}", label: "Sync Across Devices", categoryId: "feature", colorHex: "#6C5CE7"),
        IngredientData(id: "feat_a11y", emoji: "\u{267F}", label: "Accessibility Focus", categoryId: "feature", colorHex: "#00B894"),
        IngredientData(id: "feat_focus", emoji: "\u{1F319}", label: "Sleep / Focus Mode", categoryId: "feature", colorHex: "#2D3436"),
    ]

    // MARK: - Tech Stack (12)

    static let techStack: [IngredientData] = [
        IngredientData(id: "tech_swiftui", emoji: "\u{1F5BC}\u{FE0F}", label: "SwiftUI", categoryId: "techStack", colorHex: "#0984E3"),
        IngredientData(id: "tech_coredata", emoji: "\u{1F4BE}", label: "Core Data", categoryId: "techStack", colorHex: "#636E72"),
        IngredientData(id: "tech_cloudkit", emoji: "\u{2601}\u{FE0F}", label: "CloudKit", categoryId: "techStack", colorHex: "#74B9FF"),
        IngredientData(id: "tech_healthkit", emoji: "\u{2764}\u{FE0F}", label: "HealthKit", categoryId: "techStack", colorHex: "#D63031"),
        IngredientData(id: "tech_arkit", emoji: "\u{1F52E}", label: "ARKit", categoryId: "techStack", colorHex: "#A29BFE"),
        IngredientData(id: "tech_swiftdata", emoji: "\u{1F5C4}\u{FE0F}", label: "SwiftData", categoryId: "techStack", colorHex: "#6C5CE7"),
        IngredientData(id: "tech_coreml", emoji: "\u{1F9E0}", label: "Core ML", categoryId: "techStack", colorHex: "#E17055"),
        IngredientData(id: "tech_restapi", emoji: "\u{1F517}", label: "REST API", categoryId: "techStack", colorHex: "#00B894"),
        IngredientData(id: "tech_firebase", emoji: "\u{1F525}", label: "Firebase", categoryId: "techStack", colorHex: "#FDCB6E"),
        IngredientData(id: "tech_mapkit", emoji: "\u{1F5FA}\u{FE0F}", label: "MapKit", categoryId: "techStack", colorHex: "#00CEC9"),
        IngredientData(id: "tech_foundationmodel", emoji: "\u{1F916}", label: "Foundation Model", categoryId: "techStack", colorHex: "#E84393"),
        IngredientData(id: "tech_avfoundation", emoji: "\u{1F3AC}", label: "AVFoundation", categoryId: "techStack", colorHex: "#2D3436"),
    ]

    // MARK: - Monetisation (6)

    static let monetisation: [IngredientData] = [
        IngredientData(id: "money_freemium", emoji: "\u{1F4B0}", label: "Freemium", categoryId: "monetisation", colorHex: "#FDCB6E"),
        IngredientData(id: "money_subscription", emoji: "\u{1F4C5}", label: "Subscription", categoryId: "monetisation", colorHex: "#6C5CE7"),
        IngredientData(id: "money_onetime", emoji: "\u{1F3F7}\u{FE0F}", label: "One-Time Purchase", categoryId: "monetisation", colorHex: "#00B894"),
        IngredientData(id: "money_ads", emoji: "\u{1F4FA}", label: "Ad-Supported", categoryId: "monetisation", colorHex: "#E17055"),
        IngredientData(id: "money_free", emoji: "\u{1F193}", label: "Completely Free", categoryId: "monetisation", colorHex: "#74B9FF"),
        IngredientData(id: "money_enterprise", emoji: "\u{1F3E2}", label: "Enterprise License", categoryId: "monetisation", colorHex: "#2D3436"),
    ]

    // MARK: - Scale (6)

    static let scale: [IngredientData] = [
        IngredientData(id: "scale_weekend", emoji: "\u{1F680}", label: "Weekend Hack", categoryId: "scale", colorHex: "#FF7675"),
        IngredientData(id: "scale_mvp", emoji: "\u{1F9EA}", label: "MVP", categoryId: "scale", colorHex: "#FDCB6E"),
        IngredientData(id: "scale_production", emoji: "\u{2699}\u{FE0F}", label: "Production", categoryId: "scale", colorHex: "#0984E3"),
        IngredientData(id: "scale_enterprise", emoji: "\u{1F3D7}\u{FE0F}", label: "Enterprise", categoryId: "scale", colorHex: "#2D3436"),
        IngredientData(id: "scale_solo", emoji: "\u{1F464}", label: "Solo Developer", categoryId: "scale", colorHex: "#A29BFE"),
        IngredientData(id: "scale_team", emoji: "\u{1F465}", label: "Small Team", categoryId: "scale", colorHex: "#00B894"),
    ]
}
