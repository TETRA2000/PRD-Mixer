import Testing
@testable import PRD_Mixer

struct DefaultCategoriesTests {

    @Test func all_containsExpectedCount() {
        #expect(DefaultCategories.all.count == 14)
    }

    @Test func all_haveSortedOrder() {
        let sortOrders = DefaultCategories.all.map(\.sortOrder)
        #expect(sortOrders == sortOrders.sorted())
    }

    @Test func all_haveUniqueIds() {
        let ids = DefaultCategories.all.map(\.id)
        #expect(Set(ids).count == ids.count)
    }

    @Test func all_haveUniqueSortOrders() {
        let sortOrders = DefaultCategories.all.map(\.sortOrder)
        #expect(Set(sortOrders).count == sortOrders.count)
    }

    @Test func all_haveValidData() {
        for category in DefaultCategories.all {
            #expect(!category.id.isEmpty)
            #expect(!category.displayName.isEmpty)
            #expect(!category.emoji.isEmpty)
            #expect(category.colorHex.hasPrefix("#"))
            #expect(category.secondaryColorHex.hasPrefix("#"))
        }
    }

    @Test func category_forId_findsExisting() {
        let result = DefaultCategories.category(for: "appType")
        #expect(result != nil)
        #expect(result?.displayName == "App Type")
    }

    @Test func category_forId_returnsNilForUnknown() {
        let result = DefaultCategories.category(for: "nonexistent")
        #expect(result == nil)
    }
}

struct DefaultIngredientsTests {

    @Test func all_containsExpectedCount() {
        // 15 + 7 + 12 + 10 + 15 + 10 + 10 + 10 + 10 + 10 + 10 + 10 + 10 + 10 = 149
        #expect(DefaultIngredients.all.count == 149)
    }

    @Test func all_haveUniqueIds() {
        let ids = DefaultIngredients.all.map(\.id)
        #expect(Set(ids).count == ids.count)
    }

    @Test func all_haveValidData() {
        for ingredient in DefaultIngredients.all {
            #expect(!ingredient.id.isEmpty)
            #expect(!ingredient.emoji.isEmpty)
            #expect(!ingredient.label.isEmpty)
            #expect(!ingredient.categoryId.isEmpty)
            #expect(ingredient.colorHex.hasPrefix("#"))
            #expect(ingredient.isCustom == false)
        }
    }

    @Test func all_referencesValidCategories() {
        let categoryIds = Set(DefaultCategories.all.map(\.id))
        for ingredient in DefaultIngredients.all {
            #expect(categoryIds.contains(ingredient.categoryId),
                    "Ingredient \(ingredient.id) references unknown category \(ingredient.categoryId)")
        }
    }

    @Test func ingredients_forCategory_filtersCorrectly() {
        let appTypeIngredients = DefaultIngredients.ingredients(for: "appType")
        #expect(appTypeIngredients.count == 15)
        for ingredient in appTypeIngredients {
            #expect(ingredient.categoryId == "appType")
        }
    }

    @Test func ingredients_forUnknownCategory_returnsEmpty() {
        let result = DefaultIngredients.ingredients(for: "unknown")
        #expect(result.isEmpty)
    }

    @Test func perCategoryCount() {
        #expect(DefaultIngredients.appType.count == 15)
        #expect(DefaultIngredients.platform.count == 7)
        #expect(DefaultIngredients.theme.count == 12)
        #expect(DefaultIngredients.uxStyle.count == 10)
        #expect(DefaultIngredients.feature.count == 15)
        #expect(DefaultIngredients.interactionModel.count == 10)
        #expect(DefaultIngredients.vibe.count == 10)
        #expect(DefaultIngredients.gameGenre.count == 10)
        #expect(DefaultIngredients.creativeTool.count == 10)
        #expect(DefaultIngredients.world.count == 10)
        #expect(DefaultIngredients.hobby.count == 10)
        #expect(DefaultIngredients.companion.count == 10)
        #expect(DefaultIngredients.popCulture.count == 10)
        #expect(DefaultIngredients.transport.count == 10)
    }
}

struct DefaultDiscoverItemsTests {

    @Test func all_isNotEmpty() {
        #expect(!DefaultDiscoverItems.all.isEmpty)
    }

    @Test func all_haveValidIngredients() {
        for item in DefaultDiscoverItems.all {
            #expect(!item.title.isEmpty)
            #expect(!item.description.isEmpty)
            #expect(!item.ingredients.isEmpty)
            #expect(!item.prdPreview.isEmpty)
        }
    }
}

struct DefaultSystemPromptsTests {

    @Test func generationPromptBody_isNotEmpty() {
        #expect(!DefaultSystemPrompts.generationPromptBody.isEmpty)
    }
}
