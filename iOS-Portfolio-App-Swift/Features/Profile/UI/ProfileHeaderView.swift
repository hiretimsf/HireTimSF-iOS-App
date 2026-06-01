import SwiftUI

struct ProfileHeaderView: View {
    private let profile = PortfolioData.profile

    var body: some View {
        ZStack {
            Color.chromeBackground
            HeaderPattern()
                .opacity(0.16)

            VStack(spacing: 9) {
                Label(profile.greeting, systemImage: "hand.wave")
                    .font(.title3.weight(.semibold))
                BundledImage(name: "profile")
                    .frame(width: 96, height: 96)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.onChrome.opacity(0.9), lineWidth: 1))
                    .shadow(radius: 5, y: 2)
                    .accessibilityLabel("Profile picture of Tim Baz")
                Text(profile.name)
                    .font(.title3.weight(.bold))
                Text(profile.title)
                    .font(.headline)
                    .foregroundStyle(Color.onChrome.opacity(0.8))
                Link(profile.email, destination: mailURL())
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color.onChrome.opacity(0.8))
            }
            .foregroundStyle(Color.onChrome)
            .padding(.top, 12)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 280)
    }
}
