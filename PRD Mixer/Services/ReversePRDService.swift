import Foundation

/// Phase 2: Service for decomposing an existing PRD or app description
/// back into its constituent ingredients using the Foundation Model.
@Observable
final class ReversePRDService {
    var extractedIngredients: [IngredientData] = []
    var isProcessing = false
    var error: String?

    func decompose(text: String) async {
        // Phase 2 implementation:
        // 1. Send text to Foundation Model with reverse system prompt
        // 2. Parse JSON response into IngredientData array
        // 3. Update extractedIngredients property
    }
}
