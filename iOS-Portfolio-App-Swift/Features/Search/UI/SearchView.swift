import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    let portfolioViewModel: PortfolioViewModel

    @State private var viewModel: SearchViewModel

    @MainActor
    init(portfolioViewModel: PortfolioViewModel) {
        self.portfolioViewModel = portfolioViewModel
        _viewModel = State(initialValue: SearchViewModel())
    }

    var body: some View {
        @Bindable var viewModel = viewModel
        let results = viewModel.results(
            projects: portfolioViewModel.projects,
            blogPosts: portfolioViewModel.blogPosts
        )

        List(results) { result in
            VStack(alignment: .leading, spacing: 4) {
                Text(result.title)
                    .font(.headline)
                Text(result.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondaryText)
            }
            .padding(.vertical, 4)
        }
        .overlay {
            if viewModel.query.isEmpty {
                SearchEmptyState(title: "Search", description: "Type to search projects, blog posts, and about content.")
            } else if results.isEmpty {
                SearchEmptyState(title: "No results found.")
            }
        }
        .navigationTitle("Search")
        .searchable(text: $viewModel.query)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Close") { dismiss() }
            }
        }
    }
}

private struct SearchEmptyState: View {
    let title: String
    var description: String?

    var body: some View {
        VStack(spacing: 12) {
            Image("SearchIcon")
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .accessibilityHidden(true)

            Text(title)
                .font(.headline)
                .foregroundStyle(Color.primaryText)

            if let description {
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
        }
    }
}
