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
                BundledImage(name: "Profile")
                    .frame(width: 108, height: 108)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.onChrome.opacity(0.9), lineWidth: 2))
                    .shadow(radius: 5, y: 2)
                    .accessibilityLabel("Profile picture of Tim Baz")
                Text(profile.name)
                    .font(.title3.weight(.bold))
                Text(profile.title)
                    .font(.headline)
                    .foregroundStyle(Color.onChrome.opacity(0.8))
                HStack(spacing: 10) {
                    HeaderLink(title: "Email", systemImage: "envelope", url: mailURL())
                    HeaderLink(title: "Website", systemImage: "safari", url: PortfolioData.websiteURL)
                }
                .padding(.top, 6)
            }
            .foregroundStyle(Color.onChrome)
            .padding(.top, 12)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 280)
    }
}

private struct HeaderLink: View {
    let title: String
    let systemImage: String
    let url: URL

    var body: some View {
        Link(destination: url) {
            Label(title, systemImage: systemImage)
                .font(.caption.weight(.bold))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.onChrome.opacity(0.15))
                .clipShape(Capsule())
        }
        .foregroundStyle(Color.onChrome)
    }
}
