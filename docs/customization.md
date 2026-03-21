# PRD Mixer — Customization Guide

## Custom Categories

Users can create their own ingredient categories beyond the 8 built-in ones (App Type, Platform, Theme, UX Style, Feature, Interaction Model, Vibe / Spirit, Scale).

### Creating a Category

1. Navigate to **Settings** → **Ingredient Categories**
2. Tap the **+** button
3. Fill in:
   - **Name** — Display name (e.g. "Compliance", "Target Region")
   - **Emoji** — A single emoji for the category header
   - **Primary Color** — Select from the color palette
   - **Secondary Color** — For the gradient effect
4. Tap **Add**

### How It Works

- Custom categories are stored as `CustomCategory` objects in SwiftData
- They appear alongside built-in categories in the Mix tab, sorted by `sortOrder`
- Built-in categories cannot be deleted or edited
- Custom categories can be deleted (which also removes all custom ingredients in that category)

### Data Model

```swift
@Model class CustomCategory {
    var categoryId: String      // UUID string
    var displayName: String
    var emoji: String
    var colorHex: String
    var secondaryColorHex: String
    var sortOrder: Int          // Starts after built-in max (7)
}
```

## Custom Ingredients

Users can add their own ingredients to any category (built-in or custom).

### Creating an Ingredient

1. Navigate to **Settings** → **Ingredient Categories**
2. Tap a category to see its ingredients
3. Tap the **+** button
4. Fill in:
   - **Emoji** — A single emoji for the card
   - **Label** — Short name (2-4 words)
   - **Color** — Card background color
5. Tap **Add**

### How It Works

- Custom ingredients are stored as `CustomIngredient` objects in SwiftData
- They appear alongside built-in ingredients in their category's horizontal scroll
- Custom ingredients show a "Custom" badge in the manager
- They can be deleted via swipe in the ingredient list

## System Prompts

### Built-in Prompts

Three default prompts are seeded on first launch:

1. **Standard PRD** (generation) — Produces a structured Markdown PRD
2. **Smart Suggestions** (suggestion) — Returns JSON ingredient suggestions (Phase 2)
3. **Reverse Engineer** (reverse) — Decomposes text into ingredient JSON (Phase 2)

### Creating Custom Prompts

1. Navigate to **Settings** → **System Prompts**
2. Tap the **+** button
3. Fill in:
   - **Name** — Descriptive name (e.g. "Concise MVP", "Enterprise Detail")
   - **Purpose** — Generation, Suggestion, or Reverse
   - **Body** — Full prompt text in the monospaced editor
4. Tap **Add**

### Prompt Tips

- Be specific about output format (Markdown headings, bullet lists)
- Specify desired word count range
- Include instructions about tone and detail level
- Reference ingredient emojis for visual flair in output
- The active generation prompt is the first one found with purpose "generation"

## Ingredient Export/Import

### Export Format

Ingredients can be exported as JSON via `ExportService`:

```json
{
  "formatVersion": 1,
  "ingredients": [
    {
      "id": "custom_001",
      "emoji": "🏋️",
      "label": "Gym Tracker",
      "categoryId": "appType",
      "colorHex": "#E17055",
      "isCustom": true,
      "isFromSuggestion": false
    }
  ]
}
```

### Sharing

Generated PRDs can be shared via the iOS Share Sheet in:
- **Markdown** (`.md`) — Full formatting preserved
- **Plain Text** (`.txt`) — Markdown syntax stripped

Share actions are available from:
- GenerationView (after mixing)
- ProjectDetailView (saved projects)

## Cross-Tab Workflows

### Remix from Projects

1. Open a saved project in **Projects** tab
2. Tap the **Remix** button (↻ icon)
3. The project's ingredients are loaded into the Mix tab
4. Modify ingredients and mix again

### Remix from Discover

1. Browse curated PRDs in **Discover** tab
2. Tap a card → view detail
3. Tap **"Remix This"**
4. Ingredients are loaded into the Mix tab for customization

### Surprise Me

1. Tap the **dice** icon in the Mix tab toolbar
2. One random ingredient per category is selected
3. Review and adjust, then tap Mix
