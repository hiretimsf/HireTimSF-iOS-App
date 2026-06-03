protocol PortfolioService: Sendable {
    func loadProjects() async throws -> [Project]
    func loadBlogPosts() async throws -> [BlogPost]
    func loadBlogPost(slug: String) async throws -> BlogPost
}

struct LivePortfolioService: PortfolioService {
    private let repository: any PortfolioRepository

    init(repository: any PortfolioRepository) {
        self.repository = repository
    }

    func loadProjects() async throws -> [Project] {
        try await repository.fetchProjects()
    }

    func loadBlogPosts() async throws -> [BlogPost] {
        try await repository.fetchBlogPosts()
    }

    func loadBlogPost(slug: String) async throws -> BlogPost {
        try await repository.fetchBlogPost(slug: slug)
    }
}
