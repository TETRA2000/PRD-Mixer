import Foundation

struct DiscoverItem: Identifiable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let ingredients: [IngredientData]
    let prdPreview: String

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        ingredients: [IngredientData],
        prdPreview: String
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.ingredients = ingredients
        self.prdPreview = prdPreview
    }
}
