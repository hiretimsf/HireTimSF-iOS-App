import SwiftUI

struct ContactRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.appBackground)
                    .frame(width: 38, height: 38)

                Image(systemName: icon)
                    .foregroundStyle(Color.brandPrimary)
            }
            Text(title)
                .font(.body.weight(.semibold))
                .foregroundStyle(Color.primaryText)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption.weight(.bold))
                .foregroundStyle(Color.secondaryText)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 14)
    }
}
