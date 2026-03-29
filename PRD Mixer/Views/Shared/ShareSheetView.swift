#if os(iOS)
import SwiftUI
import UIKit

struct ShareSheetView: UIViewControllerRepresentable {
    let activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#elseif os(macOS)
import SwiftUI
import AppKit

struct MacShareButton: NSViewRepresentable {
    let items: [Any]
    @Binding var isPresented: Bool

    func makeNSView(context: Context) -> NSView {
        NSView()
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        guard isPresented else { return }

        DispatchQueue.main.async {
            let picker = NSSharingServicePicker(items: items)
            guard let contentView = nsView.window?.contentView else {
                isPresented = false
                return
            }
            let anchor = CGRect(
                x: contentView.bounds.maxX - 50,
                y: contentView.bounds.maxY - 10,
                width: 1,
                height: 1
            )
            picker.show(relativeTo: anchor, of: contentView, preferredEdge: .minY)
            isPresented = false
        }
    }
}
#endif
