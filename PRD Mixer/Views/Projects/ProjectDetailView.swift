import SwiftUI
import SwiftData

struct ProjectDetailView: View {
    let project: Project
    var onRemix: (([IngredientData]) -> Void)?

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showShareSheet = false
    @State private var showDeleteConfirmation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Ingredient summary
                ingredientSection

                Divider()

                // PRD content
                Text(AttributedString(fullMarkdown: project.generatedPRD))
                    .font(.body)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .navigationTitle(project.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    showShareSheet = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }

                if let onRemix {
                    Button {
                        onRemix(project.ingredients)
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    }
                }

                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .sheet(isPresented: $showShareSheet) {
            if let url = ExportService.markdownFileURL(
                title: project.title,
                content: project.generatedPRD
            ) {
                ShareSheetView(activityItems: [url])
            }
        }
        .alert("Delete Project", isPresented: $showDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                modelContext.delete(project)
                try? modelContext.save()
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete \"\(project.title)\"? This cannot be undone.")
        }
    }

    // MARK: - Ingredient Section

    private var ingredientSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ingredients")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)

            FlowLayout(spacing: 8) {
                ForEach(project.ingredients) { ingredient in
                    HStack(spacing: 4) {
                        Text(ingredient.emoji)
                            .font(.caption)
                        Text(ingredient.label)
                            .font(.caption2)
                            .fontWeight(.medium)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color(hex: ingredient.colorHex).opacity(0.15))
                    )
                }
            }
        }
    }
}

