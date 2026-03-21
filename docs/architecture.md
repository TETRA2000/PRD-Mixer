# PRD Mixer — Architecture

## Overview

PRD Mixer is a native iOS app (iOS 26+) built with SwiftUI and SwiftData. It uses the on-device Foundation Model framework for AI-powered PRD generation. The app follows an MVVM architecture with clear separation between data models, services, view models, and views.

## Module Structure

```
PRD Mixer/
├── Models/          Data types and SwiftData persistence models
├── Data/            Static default content (ingredients, categories, prompts)
├── Services/        Business logic and external framework wrappers
├── ViewModels/      UI state management and coordination
├── Views/           SwiftUI views organized by tab
└── Extensions/      Swift type extensions
```

## Data Flow

```
User Taps Ingredient Card
    → MixViewModel.toggleIngredient()
    → Updates selectedIngredients array
    → SwiftUI reactivity updates MixingBowlView, MixButton, CategoryRow

User Taps "Mix"
    → MixViewModel.mix()
    → PRDGenerationService.generate()
    → Foundation Model streams response
    → streamedText updates GenerationView in real-time

User Taps "Save"
    → MixViewModel.saveProject()
    → Creates Project model with JSON-encoded ingredients
    → SwiftData persists to disk
    → ProjectsListView auto-updates via @Query
```

## Key Design Decisions

### 1. Value Types for Ingredients & Categories

Default ingredients and categories are defined as static `[IngredientData]` and `[CategoryData]` arrays — NOT stored in SwiftData. This avoids:
- Schema migration issues when updating default content
- Accidental deletion of built-in data
- Complex relationships in the persistence layer

Only user-created custom ingredients and categories use `@Model` classes (`CustomIngredient`, `CustomCategory`).

### 2. JSON Blob Storage for Projects

`Project.ingredientsData` stores ingredients as a JSON-encoded `Data` blob rather than using SwiftData relationships. Benefits:
- Projects are fully self-contained and portable
- No orphaned relationship issues
- Easy export/import as files
- Avoids SwiftData many-to-many complexity

### 3. System Prompt Snapshots

Projects store the system prompt body as a plain string, not a relationship to a `SystemPrompt` model. This ensures PRDs remain reproducible even if the user later modifies or deletes the prompt.

### 4. Data-Driven Categories

Categories are NOT a fixed enum. `CategoryData` is a struct with a string `id`, enabling:
- 8 built-in default categories
- User-created custom categories via `CustomCategory` @Model
- Dynamic category discovery at runtime by merging defaults + custom

### 5. Foundation Model Abstraction

`PRDGenerationService` wraps the Foundation Model API behind `#if canImport(FoundationModels)` guards. In simulator mode, it generates a placeholder PRD with simulated streaming. This allows development and testing without a physical device.

### 6. @Observable over ObservableObject

All view models use the `@Observable` macro (iOS 17+), avoiding `@Published` properties and Combine. This provides cleaner syntax and better performance with SwiftUI's observation system.

## Tab Architecture

The app uses a 4-tab `TabView` with a shared `MixViewModel` that enables cross-tab workflows:

- **Mix Tab** — Primary experience. Owns the `MixViewModel` instance.
- **Projects Tab** — Lists saved projects. Provides a "Remix" callback that loads ingredients into the shared MixViewModel and switches to the Mix tab.
- **Discover Tab** — Curated gallery. Also provides "Remix" functionality.
- **Settings Tab** — Independent. Manages prompts, categories, and ingredients via SwiftData.

## Persistence

| Data | Storage | Format |
|------|---------|--------|
| Projects | SwiftData | `@Model` with JSON blob for ingredients |
| Custom Categories | SwiftData | `@Model CustomCategory` |
| Custom Ingredients | SwiftData | `@Model CustomIngredient` |
| System Prompts | SwiftData | `@Model SystemPrompt` |
| Default Data | Static arrays | In-memory, code-defined |

## Prompt Tuner CLI

A companion macOS command-line tool (`prompt-tuner`) shares the app's model and data source files via Swift Package Manager to enable prompt and ingredient iteration without deploying to a device.

### Architecture

The CLI is defined in `Package.swift` at the project root as a single executable target. It directly compiles the app's existing model files (`Ingredient.swift`, `IngredientCategory.swift`, `PromptPurpose.swift`, `SystemPrompt.swift`) and data files (`DefaultCategories.swift`, `DefaultIngredients.swift`, `DefaultSystemPrompts.swift`) alongside its own source files in `PromptTuner/Sources/`. This avoids code duplication — the CLI uses the same `IngredientData`, `CategoryData`, and prompt templates as the iOS app.

```
PromptTuner/
└── Sources/
    ├── PromptTuner.swift          Entry point (@main, ArgumentParser)
    ├── Commands/                  Subcommand implementations
    │   ├── ListCategories.swift
    │   ├── ListIngredients.swift
    │   ├── ShowPrompts.swift
    │   ├── BuildPrompt.swift
    │   ├── ValidateIds.swift
    │   ├── AddCategory.swift
    │   └── AddIngredient.swift
    └── Support/
        ├── PromptAssembler.swift  Replicates PRDGenerationService prompt construction
        ├── CustomDataStore.swift  Reads/writes custom_data.json
        └── OutputFormatter.swift  JSON and human-readable output
```

### Key Design Decisions

- **Single target** — The CLI and app source files share one SPM target, so all types have internal access and no `public` modifiers are needed on existing code.
- **No app modifications** — The Xcode project and iOS app are unaffected. SPM's `sources:` parameter selects only the files the CLI needs.
- **Custom data via JSON** — The CLI stores custom categories and ingredients in `custom_data.json` (not SwiftData), merged with defaults at runtime via `--custom-file`.
- **Prompt replication** — `PromptAssembler` reproduces the exact user prompt format from `PRDGenerationService.generate()`, ensuring what the CLI outputs matches what the app sends to the Foundation Model.
