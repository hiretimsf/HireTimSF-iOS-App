import SwiftUI

struct WelcomePageView: View {
    let page: WelcomePage

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            BundledImage(name: page.imageName)
                .frame(width: 240, height: 240)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.logoGrey.opacity(0.35), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 8)
                .accessibilityHidden(true)

            VStack(spacing: 12) {
                Text(page.title)
                    .font(.largeTitle.weight(.bold))
                Text(page.subtitle)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(Color.brandPrimary)
                Text(page.text)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.secondaryText)
                    .lineSpacing(4)
                    .frame(maxWidth: 320)
            }

            Spacer()
            Spacer()
        }
        .padding(24)
    }
}
