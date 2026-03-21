# 🧪 PRD Mixer — Product Requirements Document

**Version:** 1.0
**Date:** March 21, 2026
**Platform:** iOS (iPhone / iPad)
**Status:** Draft

---

## 1. Executive Summary

PRD Mixer is an iOS app that transforms PRD (Product Requirements Document) authoring from a blank-page writing task into a playful, tap-driven mixing experience. Users select visual, emoji-rich "ingredient" cards from curated categories, and the app generates a complete PRD by combining those ingredients through an on-device Foundation Model.

The core promise: **create a production-ready PRD without ever opening the keyboard.**

The interaction model deliberately mirrors a food-ordering app — colourful ingredient cards, a mixing bowl summary, and a satisfying generation animation — making the process feel more like play than paperwork.

PRD Mixer is designed for indie developers, hackathon participants, and anyone practising vibe coding who needs a quick but structured starting point for a new project.

---

## 2. Problem Statement

Writing a PRD from scratch is time-consuming and intimidating, especially for solo developers or small teams who want to quickly prototype ideas through vibe coding. The blank-page problem leads to incomplete or skipped documentation, which causes scope creep and unclear goals during development.

Existing PRD tools focus on enterprise collaboration and heavyweight templates. There is no lightweight, mobile-native tool that lets a single developer rapidly generate a meaningful PRD from high-level ingredients — entirely through taps.

---

## 3. Target Audience

| Segment | Description | Key Needs |
|---------|-------------|-----------|
| Indie / Solo Developers | Developers who build side-projects or ship apps solo. | Speed, low friction, mobile-friendly workflow. |
| Hackathon Participants | Teams that need to define a product in minutes, not hours. | Rapid ideation, sharable output, fun experience. |
| Vibe Coders | Developers who use AI coding assistants and need a structured prompt/spec as a seed. | PRD as input for AI-assisted code generation. |
| Aspiring Builders | Non-technical users exploring app ideas. | No jargon, visual interface, discovery of possibilities. |

---

## 4. Product Vision & Design Principles

### 4.1 Vision

PRD Mixer transforms PRD creation into a fast, keyboard-free, visually delightful experience that feels like ordering from a gourmet menu — not filling out a form.

### 4.2 Design Principles

- **No-Keyboard-First** — Every core flow is completable through tap, swipe, and drag interactions alone. The keyboard is available but never required.
- **Food-Order Metaphor** — The UX borrows visual language from food delivery apps: colourful ingredient cards with emojis, a mixing bowl / cart summary, and a satisfying generation animation.
- **Playful & Colourful** — Each ingredient card uses a distinct colour and emoji to make browsing feel more like play than work.
- **On-Device Intelligence** — All AI inference runs through the iOS Foundation Model framework, keeping data private and enabling offline use.
- **Open & Portable** — PRDs and ingredients are stored in standard formats (Markdown, JSON) and are accessible through the Files app and Share Sheet.

---

## 5. Core User Experience

### 5.1 Interaction Model

The primary interaction model mirrors a food ordering app. The journey has four phases:

1. **Browse** — Scroll through categorised ingredient cards arranged in horizontal rows.
2. **Select** — Tap ingredients to add them to the Mixing Bowl.
3. **Mix** — Review selections and tap the "Mix" button to generate the PRD.
4. **Serve** — View, edit, save, or share the finished PRD.

### 5.2 Visual Design Direction

- Rounded, card-based UI with generous padding and shadow depth.
- Each ingredient category has a signature gradient and emoji set.
- A mixing animation plays during generation (e.g. ingredients swirl into a bowl).
- Dark mode and light mode supported via iOS system appearance.
- Haptic feedback on ingredient selection and generation completion.

---

## 6. Features

### 6.1 Ingredient Selection

Users build a PRD by tapping ingredient cards arranged in horizontal, scrollable category rows. Each card displays an emoji icon, a short label, and a colour-coded background. Tapping a card adds it to the Mixing Bowl; tapping again removes it.

**Example ingredient cards:**

| Emoji | Label | Category | Effect on PRD |
|-------|-------|----------|---------------|
| 📝 | TODO List | App Type | Adds task management requirements |
| 📱 | Runs on iOS | Platform | Specifies iOS platform constraints |
| 🐱 | Cats | Theme / Audience | Adds cat-owner persona and theming |
| 🎨 | Playful UI | UX Style | Adds playful design direction |
| 🔔 | Push Notifications | Feature | Adds notification requirements |
| 💰 | Freemium | Monetisation | Adds freemium business model |

→ Combining **📝 TODO List** + **📱 Runs on iOS** + **🐱 Cats** produces a PRD for *"an iOS TODO list app for cat owners."*

### 6.2 Ingredient Categories

Ingredients are organised into the following default categories. Each category has a dedicated colour palette and emoji family:

- **App Type** — Core product archetype (e.g. TODO, Chat, Fitness Tracker, E-commerce, Journal, Weather).
- **Platform** — Target platforms (iOS, iPadOS, macOS, watchOS, visionOS, Web, Android).
- **Theme / Audience** — Domain or persona focus (e.g. Cats, Kids, Seniors, Students, Cooking, Travel).
- **UX Style** — Visual and interaction direction (e.g. Minimalist, Playful, Skeuomorphic, Brutalist, Glassmorphism).
- **Feature** — Discrete capabilities (e.g. Push Notifications, In-App Purchase, Offline Mode, Widgets, Shortcuts).
- **Tech Stack** — Technical preferences (e.g. SwiftUI, Core Data, CloudKit, HealthKit, ARKit).
- **Monetisation** — Business model (e.g. Freemium, Subscription, One-Time Purchase, Ad-supported).
- **Scale** — Project scope hints (e.g. Weekend Hack, MVP, Production, Enterprise).

### 6.3 Dynamic Ingredient Suggestion

As the user selects ingredients, the app analyses the current combination and dynamically generates new, contextually relevant ingredient cards using the on-device Foundation Model.

**Behaviour:**

- After every new selection, the app evaluates whether additional suggestions would improve the PRD.
- Suggested ingredients appear in a dedicated row labelled "✨ Suggested for you" with a sparkle animation.
- Example: selecting **Fitness Tracker** + **HealthKit** triggers suggestions like "Step Counter Widget", "Workout Charts", and "Apple Watch Companion".
- Users can dismiss suggestions or promote them to permanent custom ingredients.

### 6.4 PRD Generation (The Mix)

When the user taps the **Mix** button, the app sends the selected ingredients plus the active system prompt to the iOS Foundation Model. The model generates a structured Markdown PRD containing:

- Executive summary
- Problem statement and target audience
- Feature list with acceptance criteria
- Non-functional requirements
- Suggested tech stack and architecture notes
- Milestones and rough timeline

The generated PRD is displayed in a rich Markdown viewer within the app and can be edited inline. Generation output streams progressively so the user sees content appearing in real time.

### 6.5 Save & Project Management

Generated PRDs are persisted as projects. Each project stores:

- The selected ingredient set (JSON).
- The generated PRD (Markdown).
- The system prompt used for generation.
- Metadata (title, creation date, last-modified date).

Projects are stored using the iOS file system and are accessible through the **Files app** for backup, transfer, or version control.

### 6.6 Random PRD ("Surprise Me")

A dedicated "Surprise Me" mode randomly selects a balanced set of ingredients across categories and immediately generates a PRD. This feature is designed for inspiration, creative warm-ups, and hackathon ice-breakers.

- Users can **lock** specific categories (e.g. always iOS) while randomising the rest.
- A shuffle animation plays during randomisation.

### 6.7 Discover Mode

A curated gallery of pre-made PRDs showcasing diverse app concepts. Each discover card shows:

- A title and one-line description.
- The ingredient set used to create it.
- A **"Remix"** button to fork the ingredient set into a new project.

Discover content is bundled with the app and may be refreshed via remote configuration.

### 6.8 Reverse PRD

Users can supply an existing PRD (pasted text or imported file) or describe an existing app, and the app decomposes it back into its constituent ingredients. This enables:

- Learning which ingredients make up a successful product.
- Remixing an existing concept by swapping out individual ingredients.
- Rapid analysis of competitor apps.

### 6.9 Export & Share Ingredients

Users can export their custom ingredient sets as JSON files and share them with others via AirDrop, Messages, or any compatible app. Importing a shared ingredient file merges the new ingredients into the user's library with duplicate detection.

**JSON format example:**

```json
{
  "formatVersion": 1,
  "ingredients": [
    {
      "id": "custom_001",
      "emoji": "🏋️",
      "label": "Gym Tracker",
      "category": "appType",
      "color": "#E17055"
    }
  ]
}
```

### 6.10 Customisable System Prompts

Advanced users can create, edit, and select system prompts that control how the Foundation Model generates PRDs, ingredient suggestions, and Reverse PRD decompositions. The app ships with sensible defaults, but power users can fine-tune output style, length, and structure.

- **Prompt library** with named presets (e.g. "Concise MVP", "Detailed Enterprise", "Vibe Coding Seed").
- Prompts are editable in a full-screen text editor.
- Prompts can be shared and imported in the same JSON format as ingredients.
- Separate prompt slots for: PRD generation, ingredient suggestion, and Reverse PRD.

### 6.11 Share Sheet Integration

Generated PRDs can be shared using the native iOS Share Sheet. Supported export formats:

- Markdown (`.md`)
- Plain Text (`.txt`)
- PDF (rendered from Markdown)

The share action is available from the PRD viewer, the project list, and the generation result screen.

---

## 7. Information Architecture

The app uses a tab-based navigation with four primary tabs:

| Icon | Tab | Purpose |
|------|-----|---------|
| 🧪 | **Mix** | The main ingredient selection and PRD generation screen. |
| 📂 | **Projects** | Saved PRD projects with search and sort. |
| 🔍 | **Discover** | Curated and community PRD gallery. |
| ⚙️ | **Settings** | System prompts, ingredient management, export/import, preferences. |

### Screen Flow

```
Mix Tab
├── Category Rows (horizontal scroll)
│   └── Ingredient Cards (tap to select)
├── Mixing Bowl (floating summary)
│   └── Selected Ingredients (tap to remove)
├── "Surprise Me" button
└── "Mix" button → Generation View
    ├── Streaming PRD Viewer
    ├── Edit Mode
    └── Share / Save Actions

Projects Tab
├── Project List (sorted by date)
│   └── Project Detail
│       ├── PRD Viewer
│       ├── Ingredient Summary
│       └── Remix / Share / Delete

Discover Tab
├── Curated PRD Gallery
│   └── Discover Detail
│       ├── PRD Preview
│       ├── Ingredient Breakdown
│       └── "Remix" → Mix Tab (pre-filled)

Settings Tab
├── System Prompts
│   ├── Prompt List
│   └── Prompt Editor
├── Ingredient Manager
│   ├── Custom Ingredients
│   └── Import / Export
└── Preferences (appearance, language)
```

---

## 8. Technical Architecture

### 8.1 Platform & Frameworks

| Component | Technology |
|-----------|-----------|
| UI Framework | SwiftUI |
| AI Inference | iOS Foundation Model (on-device) |
| Persistence | SwiftData |
| File Access | FileManager + UIDocumentPickerViewController |
| Sharing | UIActivityViewController (Share Sheet) |
| Markdown Rendering | AttributedString / swift-markdown |
| Minimum Deployment | iOS 26 |

### 8.2 Data Model (Conceptual)

```
Ingredient
├── id: UUID
├── emoji: String
├── label: String
├── category: IngredientCategory (enum)
├── color: String (hex)
├── isCustom: Bool
└── isFromSuggestion: Bool

Project
├── id: UUID
├── title: String
├── createdAt: Date
├── updatedAt: Date
├── ingredients: [Ingredient]
├── systemPrompt: SystemPrompt
└── generatedPRD: String (Markdown)

SystemPrompt
├── id: UUID
├── name: String
├── body: String
├── purpose: PromptPurpose (generation | suggestion | reverse)
└── isDefault: Bool

DiscoverItem
├── id: UUID
├── title: String
├── description: String
├── ingredients: [Ingredient]
└── prdPreview: String
```

### 8.3 On-Device AI Pipeline

1. Assemble selected ingredients into a structured context payload (JSON).
2. Prepend the active system prompt.
3. Send the combined prompt to the Foundation Model for streaming generation.
4. Parse the streamed Markdown output and render progressively in the viewer.

All inference is on-device. No network calls are made for AI features.

### 8.4 File Format

Projects are stored as a directory bundle (`.prdmix`) containing:

```
MyProject.prdmix/
├── project.json       # Metadata + ingredient IDs
├── prd.md             # Generated PRD
└── prompt.json        # System prompt snapshot
```

This format is browsable in Files app and versionable in Git.

---

## 9. Non-Functional Requirements

| Attribute | Requirement |
|-----------|-------------|
| **Privacy** | All AI inference on-device. No user data leaves the device unless the user explicitly shares it. |
| **Performance** | Ingredient browsing at 60 fps. PRD generation begins streaming within 2 seconds. |
| **Offline** | Full functionality without network connectivity (Foundation Model runs on-device). |
| **Accessibility** | Full VoiceOver support. Dynamic Type. Minimum tap target 44pt. |
| **Localisation** | Ship with English (primary) and Japanese. Ingredients and system prompts are localisable. |
| **Data Portability** | All user data exportable as JSON/Markdown via Files app or Share Sheet. |
| **Device Support** | iPhone (required), iPad (optimised layout in Phase 3). |

---

## 10. Milestones & Phasing

### Phase 1 — Core Mix (MVP)

- Ingredient selection UI with default ingredient set (~80 ingredients across all categories).
- PRD generation via Foundation Model.
- Save / load projects.
- Share Sheet export (Markdown, Plain Text).
- Basic project management (list, view, delete).

### Phase 2 — Intelligence

- Dynamic ingredient suggestion.
- Reverse PRD.
- Customisable system prompts with preset library.
- Inline PRD editing.

### Phase 3 — Community & Polish

- Discover mode with curated gallery.
- Random PRD ("Surprise Me") with category locking.
- Ingredient export / import (JSON).
- PDF export.
- iPad optimised layout.
- Onboarding tutorial.

---

## 11. Success Metrics

| Metric | Target (3 months post-launch) | Measurement |
|--------|-------------------------------|-------------|
| PRDs generated per user per week | ≥ 2 | Local analytics |
| Keyboard usage during Mix flow | < 10% of sessions | Interaction tracking |
| Time from launch to first PRD | < 90 seconds | Session timing |
| Share / export rate | > 30% of generated PRDs | Share Sheet events |
| App Store rating | ≥ 4.5 | App Store Connect |

---

## 12. Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Foundation Model output quality varies across ingredient combinations. | Low-quality PRDs reduce user trust. | Customisable system prompts + post-generation editing + quality presets. |
| Foundation Model API changes in future iOS versions. | Breaking changes in AI pipeline. | Abstract AI layer behind a Swift protocol for easy swapping. |
| Limited ingredient discovery without keyboard. | Users cannot find niche ingredients. | Dynamic suggestion + optional search-as-you-type fallback. |
| On-device model size / device compatibility. | Older devices may not support Foundation Model. | iOS 26 minimum requirement; graceful fallback messaging for unsupported devices. |
| Ingredient overload — too many choices paralyse users. | Decision fatigue, abandoned sessions. | Smart defaults, curated "starter packs", and the Surprise Me escape hatch. |

---

## 13. Open Questions

- Should the app support collaborative ingredient selection via SharePlay?
- What is the maximum practical number of ingredients per PRD before generation quality degrades?
- Should Discover mode support user-submitted PRDs (community gallery)?
- Is there demand for a macOS companion app, or is iOS-only sufficient for V1?
- Should exported PRDs include a machine-readable metadata header for use in CI/CD pipelines?
- Could ingredient sets be versioned to track how a project concept evolves over time?

---

## Appendix A: Glossary

| Term | Definition |
|------|-----------|
| **Ingredient** | A selectable card representing a single attribute, feature, or constraint that shapes the generated PRD. |
| **Mixing Bowl** | The floating UI element that shows the user's current ingredient selections. |
| **Mix** | The act of generating a PRD from the selected ingredients. |
| **Reverse PRD** | The process of decomposing an existing PRD or app description back into ingredients. |
| **Foundation Model** | Apple's on-device large language model available via the iOS Foundation Model framework (iOS 26+). |
| **Vibe Coding** | A development style where AI assistants generate code from natural-language specs or PRDs. |
