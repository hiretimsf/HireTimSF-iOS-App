protocol PortfolioRepository: Sendable {
    func fetchProjects() async throws -> [Project]
    func fetchBlogPosts() async throws -> [BlogPost]
    func fetchBlogPost(slug: String) async throws -> BlogPost
    func fetchAboutContent() async throws -> AboutContent
}

struct RemotePortfolioRepository: PortfolioRepository {
    private let api: PortfolioAPI

    init(api: PortfolioAPI = PortfolioAPI()) {
        self.api = api
    }

    func fetchProjects() async throws -> [Project] {
        try await api.fetchProjects()
    }

    func fetchBlogPosts() async throws -> [BlogPost] {
        try await api.fetchBlogPosts()
    }

    func fetchBlogPost(slug: String) async throws -> BlogPost {
        try await api.fetchBlogPost(slug: slug)
    }

    func fetchAboutContent() async throws -> AboutContent {
        try await api.fetchAboutContent()
    }
}
