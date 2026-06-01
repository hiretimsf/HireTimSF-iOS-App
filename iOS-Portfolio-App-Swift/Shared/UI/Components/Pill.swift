import SwiftUI

struct Pill: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.caption.weight(.bold))
            .foregroundStyle(Color.brandPrimary)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.brandPrimary.opacity(0.12))
            .clipShape(Capsule())
    }
}
