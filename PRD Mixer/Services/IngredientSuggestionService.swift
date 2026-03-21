import Foundation

/// Phase 2: Service for dynamically suggesting contextual ingredients
/// based on the user's current selection using the Foundation Model.
@Observable
final class IngredientSuggestionService {
    var suggestions: [IngredientData] = []
    var isLoading = false

    func suggest(for selectedIngredients: [IngredientData]) async {
        // Phase 2 implementation:
        // 1. Build context from selected ingredients
        // 2. Send to Foundation Model with suggestion system prompt
        // 3. Parse JSON response into IngredientData array
        // 4. Update suggestions property
    }

    func clearSuggestions() {
        suggestions = []
    }
}
