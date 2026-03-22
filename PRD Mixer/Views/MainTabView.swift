import SwiftUI
import SwiftData

struct MainTabView: View {
    @State private var mixViewModel = MixViewModel()
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Mix", systemImage: "flask", value: 0) {
                MixView(viewModel: mixViewModel)
            }

            Tab("Projects", systemImage: "folder", value: 1) {
                ProjectsListView(onRemix: remix)
            }

            Tab("Discover", systemImage: "magnifyingglass", value: 2) {
                DiscoverView(onRemix: remix)
            }

            Tab("Settings", systemImage: "gear", value: 3) {
                SettingsView()
            }
        }
    }

    private func remix(_ ingredients: [IngredientData]) {
        mixViewModel.loadIngredients(ingredients)
        selectedTab = 0
    }
}

#Preview {
    MainTabView()
        .modelContainer(
            for: [Project.self, CustomIngredient.self, CustomCategory.self],
            inMemory: true
        )
}
