import SwiftUI

struct SettingsRow: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        Label {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .foregroundStyle(Color.primaryText)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(Color.secondaryText)
            }
        } icon: {
            Image(systemName: icon)
                .foregroundStyle(Color.brandPrimary)
        }
    }
}
