import Testing
import Foundation
@testable import PRD_Mixer

struct MixViewModelTests {

    private func makeIngredient(id: String = "test", categoryId: String = "appType") -> IngredientData {
        IngredientData(id: id, emoji: "🧪", label: "Test", categoryId: categoryId, colorHex: "#000000")
    }

    // MARK: - Selection

    @Test func toggleIngredient_addsWhenNotSelected() {
        let vm = MixViewModel()
        let ingredient = makeIngredient()
        vm.toggleIngredient(ingredient)
        #expect(vm.selectedIngredients.count == 1)
        #expect(vm.isSelected(ingredient))
    }

    @Test func toggleIngredient_removesWhenSelected() {
        let vm = MixViewModel()
        let ingredient = makeIngredient()
        vm.toggleIngredient(ingredient)
        vm.toggleIngredient(ingredient)
        #expect(vm.selectedIngredients.isEmpty)
        #expect(!vm.isSelected(ingredient))
    }

    @Test func isSelected_returnsFalseForUnselected() {
        let vm = MixViewModel()
        let ingredient = makeIngredient()
        #expect(!vm.isSelected(ingredient))
    }

    @Test func selectedCount_matchesSelectionSize() {
        let vm = MixViewModel()
        #expect(vm.selectedCount == 0)
        vm.toggleIngredient(makeIngredient(id: "a"))
        #expect(vm.selectedCount == 1)
        vm.toggleIngredient(makeIngredient(id: "b"))
        #expect(vm.selectedCount == 2)
    }

    @Test func clearSelection_removesAll() {
        let vm = MixViewModel()
        vm.toggleIngredient(makeIngredient(id: "a"))
        vm.toggleIngredient(makeIngredient(id: "b"))
        vm.clearSelection()
        #expect(vm.selectedIngredients.isEmpty)
        #expect(vm.selectedCount == 0)
    }

    // MARK: - Categories & Ingredients

    @Test func allCategories_includesDefaultCategories() {
        let vm = MixViewModel()
        let categories = vm.allCategories(customCategories: [])
        #expect(categories.count == DefaultCategories.all.count)
        #expect(categories.first?.sortOrder == 0)
    }

    @Test func allCategories_sortedBySortOrder() {
        let vm = MixViewModel()
        let categories = vm.allCategories(customCategories: [])
        for i in 0..<categories.count - 1 {
            #expect(categories[i].sortOrder <= categories[i + 1].sortOrder)
        }
    }

    @Test func ingredients_returnsDefaultsForCategory() {
        let vm = MixViewModel()
        let ingredients = vm.ingredients(for: "appType", customIngredients: [])
        #expect(ingredients.count == DefaultIngredients.appType.count)
    }

    @Test func ingredients_returnsEmptyForUnknownCategory() {
        let vm = MixViewModel()
        let ingredients = vm.ingredients(for: "nonexistent", customIngredients: [])
        #expect(ingredients.isEmpty)
    }

    // MARK: - Load Ingredients (Remix)

    @Test func loadIngredients_replacesSelection() {
        let vm = MixViewModel()
        vm.toggleIngredient(makeIngredient(id: "original"))
        let newIngredients = [makeIngredient(id: "new1"), makeIngredient(id: "new2")]
        vm.loadIngredients(newIngredients)
        #expect(vm.selectedIngredients.count == 2)
        #expect(vm.selectedIngredients[0].id == "new1")
        #expect(vm.selectedIngredients[1].id == "new2")
    }

    // MARK: - Generated Title

    @Test func generatedTitle_extractsFromMarkdownHeading() {
        let vm = MixViewModel()
        vm.toggleIngredient(makeIngredient(id: "a"))
        vm.generationService.streamedText = "# Watchful Butler\n\n## Summary\nSome text"
        #expect(vm.generatedTitle == "Watchful Butler")
    }

    @Test func generatedTitle_fallsToIngredientLabelsWhenNoHeading() {
        let vm = MixViewModel()
        vm.toggleIngredient(makeIngredient(id: "a"))
        vm.generationService.streamedText = "No heading here"
        #expect(vm.generatedTitle == "Test")
    }

    @Test func generatedTitle_fallsToIngredientLabelsWhenEmpty() {
        let vm = MixViewModel()
        vm.toggleIngredient(makeIngredient(id: "a"))
        #expect(vm.generatedTitle == "Test")
    }

    @Test func generatedTitle_returnsUntitledWhenNoIngredientsAndNoText() {
        let vm = MixViewModel()
        #expect(vm.generatedTitle == "Untitled PRD")
    }

    @Test func generatedTitle_ignoresSubheadings() {
        let vm = MixViewModel()
        vm.generationService.streamedText = "## This Is A Subheading\n\nSome text"
        #expect(vm.generatedTitle == "Untitled PRD")
    }

    // MARK: - Surprise Me

    @Test func surpriseMe_selects3to6Ingredients() {
        let vm = MixViewModel()
        vm.toggleIngredient(makeIngredient(id: "preexisting"))
        vm.surpriseMe(customCategories: [], customIngredients: [])

        // Should have cleared and then selected 3 to 6 ingredients
        #expect(vm.selectedIngredients.count >= 3)
        #expect(vm.selectedIngredients.count <= 6)

        // Verify each selected ingredient comes from a different category
        let categoryIds = Set(vm.selectedIngredients.map(\.categoryId))
        #expect(categoryIds.count == vm.selectedIngredients.count)
    }
}
