import SwiftUI
import SwiftData

struct GenerationView: View {
    @Bindable var viewModel: MixViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var showShareSheet = false
    @State private var showSaveConfirmation = false
    @State private var hasStartedGeneration = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if viewModel.generationService.isGenerating {
                    generatingHeader
                }

                if let error = viewModel.generationService.error {
                    errorView(error)
                } else if viewModel.generationService.streamedText.isEmpty && !viewModel.generationService.isGenerating {
                    emptyState
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            ingredientSection

                            Divider()

                            MarkdownBlocksView(markdown: viewModel.generationService.streamedText)
                                .textSelection(.enabled)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Generated PRD")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        viewModel.generationService.cancel()
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .primaryAction) {
                    if !viewModel.generationService.streamedText.isEmpty && !viewModel.generationService.isGenerating {
                        Button {
                            showShareSheet = true
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }

                        Button {
                            showSaveConfirmation = true
                        } label: {
                            Image(systemName: "square.and.arrow.down")
                        }
                    }
                }
            }
            .sheet(isPresented: $showShareSheet) {
                if let url = ExportService.markdownFileURL(
                    title: viewModel.projectTitle.isEmpty ? "PRD" : viewModel.projectTitle,
                    content: viewModel.generationService.streamedText
                ) {
                    ShareSheetView(activityItems: [url])
                }
            }
            .alert("Save Project", isPresented: $showSaveConfirmation) {
                TextField("Project Title", text: $viewModel.projectTitle)
                Button("Save") {
                    viewModel.saveProject(modelContext: modelContext)
                    dismiss()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Give your PRD project a name.")
            }
            .task {
                guard !hasStartedGeneration else { return }
                hasStartedGeneration = true

                let settingsVM = SettingsViewModel()
                let prompt = settingsVM.activeGenerationPrompt(modelContext: modelContext)
                await viewModel.mix(systemPrompt: prompt)
            }
        }
    }

    // MARK: - Subviews

    private var ingredientSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ingredients")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)

            FlowLayout(spacing: 8) {
                ForEach(viewModel.selectedIngredients) { ingredient in
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

    private var generatingHeader: some View {
        HStack(spacing: 12) {
            ProgressView()
            Text("Mixing your PRD...")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }

    private var emptyState: some View {
        ContentUnavailableView {
            Label("Ready to Mix", systemImage: "flask")
        } description: {
            Text("Tap Mix to generate your PRD from the selected ingredients.")
        }
    }

    private func errorView(_ message: String) -> some View {
        ContentUnavailableView {
            Label("Generation Error", systemImage: "exclamationmark.triangle")
        } description: {
            Text(message)
        } actions: {
            Button("Try Again") {
                hasStartedGeneration = false
            }
        }
    }
}
