import SwiftUI

@main
struct HireTimSFPortfolioApp: App {
    @AppStorage("themeOption") private var themeOption = AppTheme.system.rawValue
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var isShowingSplash = true
    @State private var portfolioViewModel: PortfolioViewModel

    private let appEnvironment: AppEnvironment

    init() {
        self.init(appEnvironment: .live)
    }

    @MainActor
    init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
        _portfolioViewModel = State(initialValue: PortfolioViewModel(service: appEnvironment.portfolioService))
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if isShowingSplash {
                    AppSplashView()
                        .onAppear {
                            Task { @MainActor in
                                try? await Task.sleep(nanoseconds: 2_500_000_000)
                                withAnimation(.easeOut(duration: 0.25)) {
                                    isShowingSplash = false
                                }
                            }
                        }
                } else {
                    Group {
                        if hasCompletedOnboarding {
                            RootTabView(
                                portfolioViewModel: portfolioViewModel,
                                appEnvironment: appEnvironment
                            )
                        } else {
                            OnboardingView {
                                hasCompletedOnboarding = true
                            }
                        }
                    }
                }
            }
            .preferredColorScheme(AppTheme(rawValue: themeOption)?.colorScheme)
            .task {
                await portfolioViewModel.loadIfNeeded()
            }
        }
    }
}
