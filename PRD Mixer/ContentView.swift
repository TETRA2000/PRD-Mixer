import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        #if os(macOS)
        MacSidebarView()
        #else
        MainTabView()
        #endif
    }
}

// MARK: - macOS Sidebar

#if os(macOS)
struct MacSidebarView: View {
    @State private var mixViewModel = MixViewModel()
    @State private var selection: SidebarItem? = .mix

    enum SidebarItem: String, CaseIterable, Identifiable {
        case mix = "Mix"
        case projects = "Projects"
        case discover = "Discover"
        case settings = "Settings"

        var id: String { rawValue }

        var icon: String {
            switch self {
            case .mix: "flask"
            case .projects: "folder"
            case .discover: "magnifyingglass"
            case .settings: "gear"
            }
        }
    }

    var body: some View {
        NavigationSplitView {
            List(SidebarItem.allCases, selection: $selection) { item in
                Label(item.rawValue, systemImage: item.icon)
                    .tag(item)
            }
            .navigationTitle("PRD Mixer")
        } detail: {
            switch selection {
            case .mix:
                MixView(viewModel: mixViewModel)
            case .projects:
                ProjectsListView(onRemix: remix)
            case .discover:
                DiscoverView(onRemix: remix)
            case .settings:
                SettingsView()
            case nil:
                ContentUnavailableView("Select an item", systemImage: "sidebar.left")
            }
        }
        .frame(minWidth: 700, minHeight: 500)
    }

    private func remix(_ ingredients: [IngredientData]) {
        mixViewModel.loadIngredients(ingredients)
        selection = .mix
    }
}
#endif

#Preview {
    ContentView()
        .modelContainer(
            for: [Project.self, CustomIngredient.self, CustomCategory.self],
            inMemory: true
        )
}
