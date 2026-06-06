import SwiftUI
import UIKit

struct DataDeletionView: View {
    @AppStorage("deletionIdentifier") private var deletionIdentifier = UUID().uuidString
    @State private var copied = false

    var body: some View {
        Form {
            Section {
                Text("Use this identifier when requesting deletion of analytics, crash, and performance data that can be associated with this app install.")
            }
            Section("Deletion identifier") {
                Text(deletionIdentifier)
                    .font(.footnote.monospaced())
                    .textSelection(.enabled)
                Button {
                    UIPasteboard.general.string = deletionIdentifier
                    copied = true
                } label: {
                    Label(copied ? "Deletion ID copied" : "Copy ID", systemImage: copied ? "checkmark" : "doc.on.doc")
                }
                Link(destination: mailURL(subject: "HireTimSF app data deletion request", body: deletionEmailBody(id: deletionIdentifier))) {
                    Label("Email deletion request", systemImage: "envelope")
                }
                Link(destination: PortfolioData.dataDeletionURL) {
                    Label("Data deletion instructions", systemImage: "safari")
                }
            }
        }
        .navigationTitle("Data Deletion")
    }
}
