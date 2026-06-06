import SwiftUI

struct PrimaryActionLabel: View {
    let title: String

    init(title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
        .font(.headline.weight(.bold))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background {
            LinearGradient(
                colors: [
                    Color.brandPrimary,
                    Color(red: 0.024, green: 0.714, blue: 0.831)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
        .clipShape(Capsule())
    }
}
