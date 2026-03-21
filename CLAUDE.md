# PRD Mixer

## Overview

PRD Mixer is a native iOS app that transforms PRD (Product Requirements Document) authoring into a tap-driven mixing experience. Users select emoji-rich "ingredient" cards from curated categories, and the app generates a complete, production-ready PRD using Apple's on-device Foundation Model — no keyboard required.

## Tech Stack

- **Language**: Swift
- **UI**: SwiftUI
- **Data**: SwiftData (on-device, no cloud)
- **AI**: Apple Foundation Model (iOS 26+, on-device only)
- **Architecture**: MVVM with `@Observable` macros
- **Dependencies**: None (Apple frameworks only)

## Project Structure

- `PRD Mixer/Models/` — Data types and SwiftData models
- `PRD Mixer/Data/` — Static default content (ingredients, categories, prompts)
- `PRD Mixer/Services/` — Business logic (generation, export, haptics)
- `PRD Mixer/ViewModels/` — UI state management (`@Observable`)
- `PRD Mixer/Views/` — SwiftUI views organized by tab (Mix, Projects, Discover, Settings)
- `PRD Mixer/Extensions/` — Swift type extensions
- `PromptTuner/Sources/` — Prompt Tuner CLI tool (macOS, shares app models via SPM)
- `docs/` — Architecture, data model, UI guide, and customization docs

## Build & Run

Requires Xcode 26+ and iOS 26+ deployment target.

```bash
# Build iOS app
xcodebuild -scheme "PRD Mixer" -configuration Debug

# Run tests
xcodebuild -scheme "PRD Mixer" -destination generic/platform=iOS test

# Build and run Prompt Tuner CLI (macOS)
swift build --product prompt-tuner
swift run prompt-tuner --help
```

Foundation Model features require an Apple Silicon device. The simulator uses placeholder generation with simulated streaming.

## Development Guidelines

- **Write tests**: All new features and bug fixes should include corresponding unit tests in `PRD MixerTests/` and UI tests in `PRD MixerUITests/` where appropriate.
- **Update documentation**: When changing behavior, adding features, or modifying APIs, update the relevant docs in `docs/` (architecture.md, data-model.md, foundation-model-integration.md, ui-guide.md, customization.md) and this file as needed.
