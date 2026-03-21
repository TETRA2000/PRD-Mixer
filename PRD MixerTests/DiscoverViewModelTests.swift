import Testing
@testable import PRD_Mixer

struct DiscoverViewModelTests {

    @Test func items_loadedWithDefaults() {
        let vm = DiscoverViewModel()
        #expect(vm.items.count == DefaultDiscoverItems.all.count)
        #expect(vm.items.count > 0)
    }

    @Test func items_haveValidContent() {
        let vm = DiscoverViewModel()
        for item in vm.items {
            #expect(!item.title.isEmpty)
            #expect(!item.description.isEmpty)
            #expect(!item.ingredients.isEmpty)
            #expect(!item.prdPreview.isEmpty)
        }
    }
}
