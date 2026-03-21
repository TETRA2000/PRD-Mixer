# PRD Mixer

PRD Mixer is an iOS app that transforms PRD (Product Requirements Document) authoring from a blank-page writing task into a playful, tap-driven mixing experience. Select visual, emoji-rich "ingredient" cards from curated categories, and the app generates a complete PRD using Apple's on-device Foundation Model.

**Create a production-ready PRD without ever opening the keyboard.**

## Screenshots

<p align="center">
  <img src="docs/images/IMG_9956.jpeg" width="250" alt="Mix tab — browse and select ingredient cards" />
  &nbsp;&nbsp;
  <img src="docs/images/IMG_9962.jpeg" width="250" alt="Project detail — generated PRD" />
  &nbsp;&nbsp;
  <img src="docs/images/IMG_9968.jpeg" width="250" alt="Settings — ingredient categories" />
</p>

## Features

- **Ingredient Selection** — Browse categorised cards arranged in horizontal rows. Tap to add ingredients to your Mixing Bowl.
- **PRD Generation** — Combine selected ingredients via the on-device Foundation Model to produce a structured Markdown PRD with streaming output.
- **Project Management** — Save, view, and manage generated PRDs. Remix any saved project by loading its ingredients back into the Mix tab.
- **Discover Gallery** — Browse curated pre-made PRDs and remix them as starting points.
- **Surprise Me** — Randomly select one ingredient per category for instant inspiration.
- **Custom Ingredients & Categories** — Create your own ingredients and categories beyond the 78 built-in defaults.
- **System Prompt Customisation** — Edit or create system prompts to control PRD generation style and structure.
- **Share & Export** — Export PRDs as Markdown or plain text via the iOS Share Sheet.

## Requirements

- iOS 26+
- Xcode 26+
- Apple Silicon device (for Foundation Model features)

## Architecture

The app follows MVVM with SwiftUI and SwiftData:

```
PRD Mixer/
├── Models/          Data types and SwiftData persistence models
├── Data/            Static default content (ingredients, categories, prompts)
├── Services/        Business logic (generation, export, haptics)
├── ViewModels/      UI state management and coordination
├── Views/           SwiftUI views organised by tab
└── Extensions/      Swift type extensions
```

Key technical decisions:

- **On-device AI** — All inference runs through the FoundationModels framework. No data leaves the device.
- **Value types for defaults** — Built-in ingredients and categories are static arrays, not SwiftData models, avoiding schema migration complexity.
- **JSON blob storage** — Projects store ingredients as encoded JSON, making them fully self-contained and portable.
- **@Observable** — All view models use the `@Observable` macro for cleaner SwiftUI integration.

See [`docs/`](docs/) for detailed architecture, data model, and UI documentation.

## License

All rights reserved.
