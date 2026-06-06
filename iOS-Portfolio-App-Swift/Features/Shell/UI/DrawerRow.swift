import SwiftUI

struct DrawerRow: View {
    let title: String
    let systemImage: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: systemImage)
                    .frame(width: 22, height: 22)
                    .foregroundStyle(selected ? Color.selectedItemContent : Color.primaryText)

                Text(title)
                    .foregroundStyle(selected ? Color.selectedItemContent : Color.primaryText)
            }
                .font(.body.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 28)
                .padding(.vertical, 18)
                .background {
                    if selected {
                        Rectangle()
                            .fill(Color(.tertiarySystemFill))
                    }
                }
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}
