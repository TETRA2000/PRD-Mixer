import SwiftUI

struct CustomIngredientInputView: View {
    @State private var text = ""
    var onAdd: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Custom Ingredient", systemImage: "plus.circle.fill")
                .font(.headline)

            HStack(spacing: 10) {
                TextField("Add your own ingredient…", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.done)
                    .onSubmit { addIngredient() }

                Button {
                    addIngredient()
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title2)
                }
                .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .padding(.horizontal)
    }

    private func addIngredient() {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        onAdd(trimmed)
        text = ""
    }
}

#Preview {
    CustomIngredientInputView { label in
        print("Added: \(label)")
    }
}
