struct AppEnvironment: Sendable {
    let portfolioService: any PortfolioService

    static let live: AppEnvironment = {
        let repository = RemotePortfolioRepository()
        let portfolioService = LivePortfolioService(repository: repository)
        return AppEnvironment(portfolioService: portfolioService)
    }()
}
