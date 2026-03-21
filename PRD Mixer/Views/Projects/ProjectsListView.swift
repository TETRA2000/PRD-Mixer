import SwiftUI
import SwiftData

struct ProjectsListView: View {
    @Query(sort: \Project.updatedAt, order: .reverse) private var projects: [Project]
    @Environment(\.modelContext) private var modelContext

    @State private var viewModel = ProjectsViewModel()
    var onRemix: (([IngredientData]) -> Void)?

    var body: some View {
        NavigationStack {
            Group {
                if projects.isEmpty {
                    emptyState
                } else {
                    List {
                        ForEach(projects) { project in
                            NavigationLink {
                                ProjectDetailView(project: project, onRemix: onRemix)
                            } label: {
                                ProjectRowView(project: project)
                            }
                        }
                        .onDelete { offsets in
                            viewModel.deleteProjects(
                                at: offsets,
                                from: projects,
                                modelContext: modelContext
                            )
                        }
                    }
                }
            }
            .navigationTitle("Projects")
        }
    }

    private var emptyState: some View {
        ContentUnavailableView {
            Label("No Projects Yet", systemImage: "folder")
        } description: {
            Text("Mix your first PRD from the Mix tab, then save it here.")
        }
    }
}

#Preview {
    ProjectsListView()
        .modelContainer(for: Project.self, inMemory: true)
}
