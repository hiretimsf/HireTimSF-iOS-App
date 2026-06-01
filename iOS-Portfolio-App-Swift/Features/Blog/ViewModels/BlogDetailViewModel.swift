import Observation

@MainActor
@Observable
final class BlogDetailViewModel {
    private let initialPost: BlogPost
    var post: BlogPost?
    var isLoading = false
    var errorMessage: String?

    init(initialPost: BlogPost) {
        self.initialPost = initialPost
    }

    var selectedPost: BlogPost {
        post ?? initialPost
    }

    func loadIfNeeded(using portfolio: PortfolioViewModel) async {
        guard post == nil, !isLoading else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            post = try await portfolio.fetchBlogPost(slug: initialPost.slug)
            errorMessage = nil
        } catch is CancellationError {
            errorMessage = nil
        } catch {
            errorMessage = "Unable to load full post. Showing summary content."
        }
    }
}
