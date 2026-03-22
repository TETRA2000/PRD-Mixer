import Foundation

enum DefaultIngredients {
    static let all: [IngredientData] = appType + platform + theme + uxStyle + feature + interactionModel + vibe + gameGenre + creativeTool + world

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
        IngredientData(id: "appType_notes", emoji: "\u{1F4D2}", label: "Note Taking", categoryId: "appType", colorHex: "#FDCB6E"),
        IngredientData(id: "appType_socialfeed", emoji: "\u{1F4E2}", label: "Social Feed", categoryId: "appType", colorHex: "#E84393"),
        IngredientData(id: "appType_forum", emoji: "\u{1F465}", label: "Community Forum", categoryId: "appType", colorHex: "#636E72"),
        IngredientData(id: "appType_project", emoji: "\u{1F4CB}", label: "Project Manager", categoryId: "appType", colorHex: "#2D3436"),
        IngredientData(id: "appType_calendar", emoji: "\u{1F5D3}\u{FE0F}", label: "Calendar / Scheduler", categoryId: "appType", colorHex: "#0984E3"),
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

    // MARK: - Interaction Model (10)

    static let interactionModel: [IngredientData] = [
        IngredientData(id: "interact_voice", emoji: "\u{1F399}\u{FE0F}", label: "Voice-First", categoryId: "interactionModel", colorHex: "#636E72"),
        IngredientData(id: "interact_gesture", emoji: "\u{1F44B}", label: "Gesture-Based", categoryId: "interactionModel", colorHex: "#74B9FF"),
        IngredientData(id: "interact_onehand", emoji: "\u{1F44D}", label: "One-Handed", categoryId: "interactionModel", colorHex: "#A29BFE"),
        IngredientData(id: "interact_keyboard", emoji: "\u{2328}\u{FE0F}", label: "Keyboard-Heavy", categoryId: "interactionModel", colorHex: "#2D3436"),
        IngredientData(id: "interact_haptic", emoji: "\u{1F4F3}", label: "Haptic-Rich", categoryId: "interactionModel", colorHex: "#E84393"),
        IngredientData(id: "interact_convo", emoji: "\u{1F4AC}", label: "Conversational", categoryId: "interactionModel", colorHex: "#0984E3"),
        IngredientData(id: "interact_swipe", emoji: "\u{1F449}", label: "Swipe-Driven", categoryId: "interactionModel", colorHex: "#E17055"),
        IngredientData(id: "interact_tap", emoji: "\u{1F446}", label: "Tap & Go", categoryId: "interactionModel", colorHex: "#00B894"),
        IngredientData(id: "interact_drag", emoji: "\u{270B}\u{FE0F}", label: "Drag & Drop", categoryId: "interactionModel", colorHex: "#6C5CE7"),
        IngredientData(id: "interact_ambient", emoji: "\u{1F30A}", label: "Ambient / Passive", categoryId: "interactionModel", colorHex: "#00CEC9"),
    ]

    // MARK: - Vibe / Spirit (10)

    static let vibe: [IngredientData] = [
        IngredientData(id: "vibe_serious", emoji: "\u{1F4BC}", label: "Serious Tool", categoryId: "vibe", colorHex: "#2D3436"),
        IngredientData(id: "vibe_joke", emoji: "\u{1F921}", label: "Joke / Parody", categoryId: "vibe", colorHex: "#FDCB6E"),
        IngredientData(id: "vibe_experimental", emoji: "\u{1F52C}", label: "Experimental", categoryId: "vibe", colorHex: "#A29BFE"),
        IngredientData(id: "vibe_retro", emoji: "\u{1F4FC}", label: "Retro", categoryId: "vibe", colorHex: "#E17055"),
        IngredientData(id: "vibe_wholesome", emoji: "\u{1F33B}", label: "Wholesome", categoryId: "vibe", colorHex: "#00B894"),
        IngredientData(id: "vibe_edgy", emoji: "\u{1F525}", label: "Edgy", categoryId: "vibe", colorHex: "#D63031"),
        IngredientData(id: "vibe_absurdist", emoji: "\u{1F92A}", label: "Absurdist", categoryId: "vibe", colorHex: "#6C5CE7"),
        IngredientData(id: "vibe_cozy", emoji: "\u{2615}", label: "Cozy", categoryId: "vibe", colorHex: "#FDCB6E"),
        IngredientData(id: "vibe_zen", emoji: "\u{1F9D8}", label: "Minimalist Zen", categoryId: "vibe", colorHex: "#74B9FF"),
        IngredientData(id: "vibe_punk", emoji: "\u{1F3B8}", label: "Punk / DIY", categoryId: "vibe", colorHex: "#E84393"),
    ]

    // MARK: - Game Genre (10)

    static let gameGenre: [IngredientData] = [
        IngredientData(id: "game_rpg", emoji: "\u{2694}\u{FE0F}", label: "RPG", categoryId: "gameGenre", colorHex: "#E74C3C"),
        IngredientData(id: "game_fps", emoji: "\u{1F52B}", label: "FPS", categoryId: "gameGenre", colorHex: "#C0392B"),
        IngredientData(id: "game_puzzle", emoji: "\u{1F9E9}", label: "Puzzle", categoryId: "gameGenre", colorHex: "#FF6B6B"),
        IngredientData(id: "game_rhythm", emoji: "\u{1F941}", label: "Rhythm", categoryId: "gameGenre", colorHex: "#E74C3C"),
        IngredientData(id: "game_vn", emoji: "\u{1F4D6}", label: "Visual Novel", categoryId: "gameGenre", colorHex: "#C0392B"),
        IngredientData(id: "game_tower", emoji: "\u{1F3F0}", label: "Tower Defense", categoryId: "gameGenre", colorHex: "#FF6B6B"),
        IngredientData(id: "game_idle", emoji: "\u{1F4A4}", label: "Idle / Clicker", categoryId: "gameGenre", colorHex: "#E74C3C"),
        IngredientData(id: "game_br", emoji: "\u{1F3C6}", label: "Battle Royale", categoryId: "gameGenre", colorHex: "#C0392B"),
        IngredientData(id: "game_lifesim", emoji: "\u{1F3E0}", label: "Life Sim", categoryId: "gameGenre", colorHex: "#FF6B6B"),
        IngredientData(id: "game_roguelike", emoji: "\u{1F480}", label: "Roguelike", categoryId: "gameGenre", colorHex: "#E74C3C"),
    ]

    // MARK: - Creative Tool (10)

    static let creativeTool: [IngredientData] = [
        IngredientData(id: "creative_graphicdesign", emoji: "\u{1F3A8}", label: "Graphic Design", categoryId: "creativeTool", colorHex: "#8E44AD"),
        IngredientData(id: "creative_video", emoji: "\u{1F3AC}", label: "Video Editing", categoryId: "creativeTool", colorHex: "#9B59B6"),
        IngredientData(id: "creative_musicprod", emoji: "\u{1F3B9}", label: "Music Production", categoryId: "creativeTool", colorHex: "#BB6BD9"),
        IngredientData(id: "creative_3d", emoji: "\u{1F9CA}", label: "3D Modeling", categoryId: "creativeTool", colorHex: "#8E44AD"),
        IngredientData(id: "creative_animation", emoji: "\u{1F39E}\u{FE0F}", label: "Animation", categoryId: "creativeTool", colorHex: "#9B59B6"),
        IngredientData(id: "creative_illustration", emoji: "\u{270F}\u{FE0F}", label: "Illustration", categoryId: "creativeTool", colorHex: "#BB6BD9"),
        IngredientData(id: "creative_comic", emoji: "\u{1F4AC}", label: "Comic Maker", categoryId: "creativeTool", colorHex: "#8E44AD"),
        IngredientData(id: "creative_meme", emoji: "\u{1F602}", label: "Meme Generator", categoryId: "creativeTool", colorHex: "#9B59B6"),
        IngredientData(id: "creative_font", emoji: "\u{1F524}", label: "Font Design", categoryId: "creativeTool", colorHex: "#BB6BD9"),
        IngredientData(id: "creative_sticker", emoji: "\u{1FA79}", label: "Sticker Maker", categoryId: "creativeTool", colorHex: "#8E44AD"),
    ]

    // MARK: - World / Setting (10)

    static let world: [IngredientData] = [
        IngredientData(id: "world_coffeeshop", emoji: "\u{2615}", label: "Coffee Shop", categoryId: "world", colorHex: "#27AE60"),
        IngredientData(id: "world_space", emoji: "\u{1F680}", label: "Space Station", categoryId: "world", colorHex: "#2ECC71"),
        IngredientData(id: "world_underwater", emoji: "\u{1F420}", label: "Underwater", categoryId: "world", colorHex: "#6BCB77"),
        IngredientData(id: "world_castle", emoji: "\u{1F3F0}", label: "Medieval Castle", categoryId: "world", colorHex: "#27AE60"),
        IngredientData(id: "world_haunted", emoji: "\u{1F47B}", label: "Haunted House", categoryId: "world", colorHex: "#2ECC71"),
        IngredientData(id: "world_island", emoji: "\u{1F3DD}\u{FE0F}", label: "Tropical Island", categoryId: "world", colorHex: "#6BCB77"),
        IngredientData(id: "world_tokyo", emoji: "\u{1F5FC}", label: "Tokyo Street", categoryId: "world", colorHex: "#27AE60"),
        IngredientData(id: "world_pizza", emoji: "\u{1F355}", label: "Pizza Kitchen", categoryId: "world", colorHex: "#2ECC71"),
        IngredientData(id: "world_cabin", emoji: "\u{1F3D5}\u{FE0F}", label: "Cozy Cabin", categoryId: "world", colorHex: "#6BCB77"),
        IngredientData(id: "world_park", emoji: "\u{1F3A2}", label: "Amusement Park", categoryId: "world", colorHex: "#27AE60"),
    ]
}
