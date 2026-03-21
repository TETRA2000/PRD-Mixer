import Foundation

enum DefaultDiscoverItems {
    static let all: [DiscoverItem] = [
        DiscoverItem(
            title: "Cat Care Companion",
            description: "A playful iOS app for cat owners to track feeding, vet visits, and daily care routines.",
            ingredients: [
                DefaultIngredients.appType.first { $0.id == "appType_todo" }!,
                DefaultIngredients.platform.first { $0.id == "platform_ios" }!,
                DefaultIngredients.theme.first { $0.id == "theme_cats" }!,
                DefaultIngredients.uxStyle.first { $0.id == "ux_playful" }!,
                DefaultIngredients.feature.first { $0.id == "feat_push" }!,
                DefaultIngredients.interactionModel.first { $0.id == "interact_tap" }!,
                DefaultIngredients.vibe.first { $0.id == "vibe_wholesome" }!,
                DefaultIngredients.scale.first { $0.id == "scale_mvp" }!,
            ],
            prdPreview: """
            # Cat Care Companion

            ## Executive Summary
            Cat Care Companion is a delightful iOS app designed for cat owners who want to stay on top of \
            their feline friends' daily needs. Track feeding schedules, vet appointments, medication \
            reminders, and daily care routines — all wrapped in a playful, cat-themed interface.

            ## Core Features
            - Feeding schedule tracker with push notification reminders
            - Vet visit calendar with appointment booking
            - Health log for tracking weight, vaccinations, and medications
            - Photo journal for capturing daily moments
            - Multi-cat household support
            """
        ),
        DiscoverItem(
            title: "Weekend Fitness Sprint",
            description: "A minimalist fitness tracker built for weekend warriors who want quick workouts without the complexity.",
            ingredients: [
                DefaultIngredients.appType.first { $0.id == "appType_fitness" }!,
                DefaultIngredients.platform.first { $0.id == "platform_ios" }!,
                DefaultIngredients.theme.first { $0.id == "theme_health" }!,
                DefaultIngredients.uxStyle.first { $0.id == "ux_minimalist" }!,
                DefaultIngredients.feature.first { $0.id == "feat_offline" }!,
                DefaultIngredients.interactionModel.first { $0.id == "interact_onehand" }!,
                DefaultIngredients.vibe.first { $0.id == "vibe_serious" }!,
                DefaultIngredients.scale.first { $0.id == "scale_weekend" }!,
            ],
            prdPreview: """
            # Weekend Fitness Sprint

            ## Executive Summary
            A stripped-down fitness tracker that respects your time. No social features, no gamification \
            bloat — just quick workout logging with HealthKit integration that works entirely offline.

            ## Core Features
            - One-tap workout start with auto-detection
            - HealthKit sync for steps, heart rate, and calories
            - Weekly summary with simple progress charts
            - Offline-first architecture — no account required
            """
        ),
        DiscoverItem(
            title: "Student Study Hub",
            description: "A collaborative study platform for students with flashcards, timers, and social accountability.",
            ingredients: [
                DefaultIngredients.appType.first { $0.id == "appType_todo" }!,
                DefaultIngredients.platform.first { $0.id == "platform_ios" }!,
                DefaultIngredients.platform.first { $0.id == "platform_ipados" }!,
                DefaultIngredients.theme.first { $0.id == "theme_students" }!,
                DefaultIngredients.uxStyle.first { $0.id == "ux_colorful" }!,
                DefaultIngredients.feature.first { $0.id == "feat_sync" }!,
                DefaultIngredients.feature.first { $0.id == "feat_social" }!,
                DefaultIngredients.interactionModel.first { $0.id == "interact_swipe" }!,
                DefaultIngredients.vibe.first { $0.id == "vibe_cozy" }!,
                DefaultIngredients.scale.first { $0.id == "scale_production" }!,
            ],
            prdPreview: """
            # Student Study Hub

            ## Executive Summary
            Student Study Hub is a vibrant study companion app for iOS and iPadOS that combines task \
            management, flashcard creation, Pomodoro timers, and social accountability features to help \
            students stay focused and motivated.

            ## Core Features
            - Smart task lists with deadline tracking and priority sorting
            - Flashcard creator with spaced repetition algorithm
            - Pomodoro timer with customisable focus/break intervals
            - Study groups with shared progress tracking
            - Achievement badges and streak tracking
            """
        ),
    ]
}
