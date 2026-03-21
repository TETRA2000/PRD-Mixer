# PRD Mixer — Data Model

## Value Types

### IngredientData

The core value type representing a single ingredient card. Used everywhere in the app.

```swift
struct IngredientData: Codable, Identifiable, Hashable {
    let id: String           // Stable identifier (e.g. "appType_todo")
    var emoji: String        // Display emoji (e.g. "📝")
    var label: String        // Short label (e.g. "TODO List")
    var categoryId: String   // References CategoryData.id
    var colorHex: String     // Card background color (e.g. "#6C5CE7")
    var isCustom: Bool       // Whether user-created
    var isFromSuggestion: Bool // Whether AI-suggested (Phase 2)
}
```

### CategoryData

Represents an ingredient category (both built-in and custom).

```swift
struct CategoryData: Codable, Identifiable, Hashable {
    let id: String                // Stable identifier (e.g. "appType")
    var displayName: String       // Human-readable name
    var emoji: String             // Category header emoji
    var colorHex: String          // Primary gradient color
    var secondaryColorHex: String // Secondary gradient color
    var sortOrder: Int            // Display order
    var isDefault: Bool           // Built-in vs custom
}
```

## SwiftData Models

### Project

Persisted PRD project.

| Field | Type | Description |
|-------|------|-------------|
| projectId | UUID | Unique identifier |
| title | String | User-given project name |
| createdAt | Date | Creation timestamp |
| updatedAt | Date | Last modification timestamp |
| ingredientsData | Data | JSON-encoded `[IngredientData]` |
| systemPromptBody | String | Snapshot of the prompt used |
| generatedPRD | String | Generated Markdown content |

Computed properties: `ingredients`, `ingredientEmojis`, `wordCount`.

### CustomIngredient

User-created ingredient persisted in SwiftData.

| Field | Type | Description |
|-------|------|-------------|
| ingredientId | String | Unique identifier (UUID string) |
| emoji | String | Display emoji |
| label | String | Short label |
| categoryId | String | References a category |
| colorHex | String | Card color |

### CustomCategory

User-created category persisted in SwiftData.

| Field | Type | Description |
|-------|------|-------------|
| categoryId | String | Unique identifier (UUID string) |
| displayName | String | Category name |
| emoji | String | Header emoji |
| colorHex | String | Primary gradient color |
| secondaryColorHex | String | Secondary gradient color |
| sortOrder | Int | Display order (starts after built-in max) |

### SystemPrompt

AI prompt template.

| Field | Type | Description |
|-------|------|-------------|
| promptId | UUID | Unique identifier |
| name | String | Display name |
| body | String | Full prompt text |
| purposeRaw | String | Enum raw value: generation, suggestion, reverse |
| isDefault | Bool | Whether this is a built-in prompt |

## Enums

### PromptPurpose

```swift
enum PromptPurpose: String, Codable {
    case generation   // PRD generation
    case suggestion   // Ingredient suggestion (Phase 2)
    case reverse      // Reverse PRD decomposition (Phase 2)
}
```

## Default Data Sets

### Categories (8 built-in)

| ID | Name | Emoji |
|----|------|-------|
| appType | App Type | 🧩 |
| platform | Platform | 📱 |
| theme | Theme / Audience | 🎭 |
| uxStyle | UX Style | 🎨 |
| feature | Feature | ⚡ |
| interactionModel | Interaction Model | 🤛 |
| vibe | Vibe / Spirit | 🪄 |
| scale | Scale | 📏 |

### Ingredients (80 built-in)

- App Type: 10 ingredients
- Platform: 7 ingredients
- Theme / Audience: 12 ingredients
- UX Style: 10 ingredients
- Feature: 15 ingredients
- Interaction Model: 10 ingredients
- Vibe / Spirit: 10 ingredients
- Scale: 6 ingredients

### System Prompts (3 defaults)

1. **Standard PRD** (generation) — Detailed instructions for structured Markdown PRD output
2. **Smart Suggestions** (suggestion) — JSON-format ingredient suggestions
3. **Reverse Engineer** (reverse) — Decompose PRD/description into ingredient JSON

## Serialization

### Project Ingredient Storage

Ingredients within a project are stored as a JSON-encoded `[IngredientData]` array in the `ingredientsData: Data` field. Example:

```json
[
  {"id": "appType_todo", "emoji": "📝", "label": "TODO List", "categoryId": "appType", "colorHex": "#6C5CE7", "isCustom": false, "isFromSuggestion": false},
  {"id": "platform_ios", "emoji": "📱", "label": "iOS", "categoryId": "platform", "colorHex": "#0984E3", "isCustom": false, "isFromSuggestion": false}
]
```

### Ingredient Export Format

```json
{
  "formatVersion": 1,
  "ingredients": [...]
}
```
