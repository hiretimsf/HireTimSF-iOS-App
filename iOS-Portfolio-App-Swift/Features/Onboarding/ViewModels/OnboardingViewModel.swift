import Observation

@MainActor
@Observable
final class OnboardingViewModel {
    let pages: [WelcomePage]
    var selectedPageIndex = 0

    init(pages: [WelcomePage] = PortfolioData.welcome) {
        self.pages = pages
    }

    var isLastPage: Bool {
        selectedPageIndex == pages.indices.last
    }

    var primaryButtonTitle: String {
        isLastPage ? "Finish" : "Next"
    }

    func advance() -> Bool {
        guard !isLastPage else { return true }
        selectedPageIndex += 1
        return false
    }
}
