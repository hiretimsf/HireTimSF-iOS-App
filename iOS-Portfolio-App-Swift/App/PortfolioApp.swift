import SwiftUI

@main
struct HireTimSFPortfolioApp: App {
    @AppStorage("themeOption") private var themeOption = AppTheme.system.rawValue
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var portfolioViewModel = PortfolioViewModel()

    var body: some Scene {
        WindowGroup {
            Group {
                if hasCompletedOnboarding {
                    RootTabView()
                } else {
                    OnboardingView {
                        hasCompletedOnboarding = true
                    }
                }
            }
            .preferredColorScheme(AppTheme(rawValue: themeOption)?.colorScheme)
            .environment(portfolioViewModel)
            .task {
                await portfolioViewModel.loadIfNeeded()
            }
        }
    }
}
