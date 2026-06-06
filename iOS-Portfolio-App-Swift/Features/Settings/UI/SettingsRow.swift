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
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.brandPrimary.opacity(0.12))
                    .frame(width: 34, height: 34)
                Image(systemName: icon)
                    .foregroundStyle(Color.brandPrimary)
            }
        }
    }
}
