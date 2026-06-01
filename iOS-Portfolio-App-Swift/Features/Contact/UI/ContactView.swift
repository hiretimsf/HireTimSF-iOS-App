import SwiftUI

struct ContactView: View {
    @Environment(\.dismiss) private var dismiss
    private let profile = PortfolioData.profile

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                BundledImage(name: "profile")
                    .frame(width: 132, height: 132)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.brandPrimary, lineWidth: 2))
                    .padding(.top, 16)

                VStack(spacing: 6) {
                    Text(profile.name)
                        .font(.title.weight(.bold))
                    Text(profile.title)
                        .font(.headline)
                        .foregroundStyle(Color.secondaryText)
                }

                ContactSection(title: "Email") {
                    Link(destination: mailURL()) {
                        ContactRow(icon: "envelope", title: profile.email)
                    }
                }

                ContactSection(title: "Social") {
                    ForEach(profile.socials) { social in
                        Link(destination: social.url) {
                            ContactRow(icon: social.systemImage, title: social.name)
                        }
                    }
                }
            }
            .padding(20)
        }
        .background(Color.appBackground)
        .navigationTitle("Contact")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Close") { dismiss() }
            }
        }
    }
}
