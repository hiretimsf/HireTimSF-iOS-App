import SwiftUI

struct SettingsView: View {
    @AppStorage("themeOption") private var themeOption = AppTheme.system.rawValue
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some View {
        List {
            Section("Display Options") {
                Picker("Choose theme", selection: $themeOption) {
                    ForEach(AppTheme.allCases) { theme in
                        Text(theme.title).tag(theme.rawValue)
                    }
                }
            }

            Section("App Info") {
                ForEach(PortfolioData.appInfo) { item in
                    LabeledContent(item.title, value: item.text)
                }
                Link(destination: PortfolioData.sourceCodeURL) {
                    SettingsRow(icon: "chevron.left.forwardslash.chevron.right", title: "Source code", subtitle: "Licensed under the Apache License")
                }
                Link(destination: PortfolioData.privacyURL) {
                    SettingsRow(icon: "lock.shield", title: "Protecting Your Privacy", subtitle: "External link")
                }
                NavigationLink {
                    DataDeletionView()
                } label: {
                    SettingsRow(icon: "person.crop.circle.badge.xmark", title: "Data Deletion", subtitle: "Request app data deletion")
                }
                Link(destination: PortfolioData.rateURL) {
                    SettingsRow(icon: "star", title: "Rate This App", subtitle: "External link")
                }
            }

            Section("Designed and Developed by") {
                if let xProfile = PortfolioData.profile.socials.first(where: { $0.id == "x" }) {
                    Link(destination: xProfile.url) {
                        SettingsRow(icon: "person.crop.circle", title: "@hiretimsf", subtitle: "You can find me on X")
                    }
                }
            }

            Section {
                Button {
                    hasCompletedOnboarding = false
                } label: {
                    SettingsRow(icon: "rectangle.on.rectangle", title: "Show Onboarding", subtitle: "Replay the welcome screens")
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.appBackground)
    }
}
