# PRD Mixer — UI Guide

## Screen Inventory

### Tab Bar (4 tabs)

| Tab | Icon | View | Purpose |
|-----|------|------|---------|
| Mix | flask | MixView | Ingredient selection + PRD generation |
| Projects | folder | ProjectsListView | Saved project management |
| Discover | magnifyingglass | DiscoverView | Curated PRD gallery |
| Settings | gear | SettingsView | Configuration and customization |

### Navigation Flow

```
Mix Tab
├── MixView (ingredient browsing)
│   ├── CategoryRow × N (horizontal scroll per category)
│   │   └── IngredientCard × N (tap to select/deselect)
│   ├── MixingBowlView (floating bottom overlay)
│   │   └── IngredientChip × N (tap × to remove)
│   ├── MixButton (triggers generation)
│   └── GenerationView (full-screen cover)
│       ├── Streaming MarkdownView
│       ├── Save alert (title input)
│       └── ShareSheetView

Projects Tab
├── ProjectsListView
│   └── ProjectRowView × N
│       └── ProjectDetailView (push)
│           ├── Ingredient summary (FlowLayout)
│           ├── PRD content (MarkdownView)
│           └── Share / Remix / Delete

Discover Tab
├── DiscoverView
│   └── DiscoverCardView × N
│       └── DiscoverDetailView (push)
│           ├── Ingredient breakdown
│           ├── Remix button
│           └── PRD preview

Settings Tab
├── SettingsView
│   └── IngredientManagerView (push)
│       ├── CategoryIngredientsView (push)
│       │   └── IngredientEditorView (sheet)
│       └── CategoryEditorView (sheet)
```

## Component Hierarchy

### IngredientCard
- Size: 100 × 120 points
- Content: emoji (36pt) + label (caption, 2-line max)
- Background: `LinearGradient` from `colorHex`
- Selected state: white border (3pt), checkmark badge, scale 1.05, glow shadow
- Animation: `.spring(duration: 0.3)`
- Accessibility: label + selected trait, custom hint

### CategoryRow
- Header: emoji + category name + selected count badge
- Content: horizontal `ScrollView` with `LazyHStack`
- Scroll behavior: `.viewAligned`
- Spacing: 12pt between cards

### MixingBowlView
- Position: floating at bottom, above MixButton
- Material: `.ultraThinMaterial` with rounded corners (20pt)
- Collapsed: header bar with bowl emoji + count badge
- Expanded: horizontal scroll of `IngredientChip` + "Clear All" button
- Animation: `.spring(duration: 0.4)` for expand/collapse

### MixButton
- Full-width, 16pt vertical padding
- Gradient: purple → blue when enabled, gray when disabled
- Pulsing animation: scale 1.02, shadow expansion, 1.5s cycle
- Label: "Mix N Ingredients" or "Select Ingredients to Mix"

### FlowLayout
Custom `Layout` implementation for wrapping ingredient chips in project detail and discover views.

## Design Tokens

### Colors (category gradients)

| Category | Primary | Secondary |
|----------|---------|-----------|
| App Type | #6C5CE7 | #A29BFE |
| Platform | #0984E3 | #74B9FF |
| Theme | #E17055 | #FAB1A0 |
| UX Style | #E84393 | #FD79A8 |
| Feature | #00B894 | #55EFC4 |
| Tech Stack | #636E72 | #B2BEC3 |
| Monetisation | #FDCB6E | #FFEAA7 |
| Scale | #00CEC9 | #81ECEC |

### Spacing

- Card spacing: 12pt
- Category row vertical spacing: 24pt
- Section padding: 16pt horizontal
- Bottom safe area for bowl + button: ~180pt

### Typography

| Element | Font | Size |
|---------|------|------|
| Card emoji | System | 36pt |
| Card label | Caption, semibold | System |
| Category header | Headline | System |
| Section header | Subheadline, semibold | System |
| Body text | Body | System |
| Chip text | Caption2, medium | System |

### Corner Radii

| Element | Radius |
|---------|--------|
| IngredientCard | 16pt |
| MixingBowl | 20pt |
| MixButton | 16pt |
| Discover card | 16pt |
| Color picker circle | Full (circle) |

## Haptic Feedback

| Action | Feedback |
|--------|----------|
| Select ingredient | Light impact |
| Remove ingredient | Rigid impact (0.5 intensity) |
| Tap Mix button | Medium impact |
| Generation complete | Success notification |
| Error | Error notification |

## Accessibility

- All cards have `accessibilityLabel` and `accessibilityHint`
- Selected state uses `.isSelected` trait
- Dynamic Type supported throughout
- Minimum tap target: 44pt (enforced by card sizing)
- Text selection enabled on generated PRD content
- VoiceOver-friendly navigation structure
