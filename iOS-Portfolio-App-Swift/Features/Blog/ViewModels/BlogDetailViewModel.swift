import Observation

@MainActor
@Observable
final class BlogDetailViewModel {
    private let initialPost: BlogPost
    private let service: any PortfolioService

    var post: BlogPost?
    var isLoading = false
    var errorMessage: String?

    init(initialPost: BlogPost, service: any PortfolioService) {
        self.initialPost = initialPost
        self.service = service
    }

    var selectedPost: BlogPost {
        post ?? initialPost
    }

    func loadIfNeeded() async {
        guard post == nil, !isLoading else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            post = try await service.loadBlogPost(slug: initialPost.slug)
            errorMessage = nil
        } catch is CancellationError {
            errorMessage = nil
        } catch {
            errorMessage = "Unable to load full post. Showing summary content."
        }
    }
}
