import SwiftUI

struct MarkdownView: View {
    let markdown: String

    var body: some View {
        ScrollView {
            Text(AttributedString(fullMarkdown: markdown))
                .font(.body)
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
    }
}

#Preview {
    MarkdownView(markdown: """
    # Sample PRD

    ## Executive Summary

    This is a **sample** PRD with *markdown* formatting.

    ## Features

    - Feature one
    - Feature two
    - Feature three

    ## Technical Notes

    Uses `SwiftUI` and `SwiftData` for the core architecture.
    """)
}
