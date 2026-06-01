import Observation

@MainActor
@Observable
final class PortfolioViewModel {
    var projects: [Project]
    var blogPosts: [BlogPost]
    var isLoadingProjects = false
    var isLoadingBlogPosts = false
    var projectError: String?
    var blogError: String?

    private let repository: PortfolioRepository
    private var hasLoaded = false

    init(
        repository: PortfolioRepository = RemotePortfolioRepository(),
        projects: [Project] = PortfolioData.projects,
        blogPosts: [BlogPost] = PortfolioData.blogPosts
    ) {
        self.repository = repository
        self.projects = projects
        self.blogPosts = blogPosts
    }

    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        hasLoaded = true
        await refresh()
    }

    func refresh() async {
        await loadProjects()
        await loadBlogPosts()
    }

    func loadProjects() async {
        isLoadingProjects = true
        defer { isLoadingProjects = false }

        do {
            projects = try await repository.fetchProjects()
            projectError = nil
        } catch is CancellationError {
            projectError = nil
        } catch {
            projectError = "Unable to load latest projects. Showing bundled content."
        }
    }

    func loadBlogPosts() async {
        isLoadingBlogPosts = true
        defer { isLoadingBlogPosts = false }

        do {
            blogPosts = try await repository.fetchBlogPosts()
            blogError = nil
        } catch is CancellationError {
            blogError = nil
        } catch {
            blogError = "Unable to load latest blog posts. Showing bundled content."
        }
    }

    func fetchBlogPost(slug: String) async throws -> BlogPost {
        try await repository.fetchBlogPost(slug: slug)
    }
}
