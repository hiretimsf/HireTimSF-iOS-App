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
                ContentUnavailableView("Search", systemImage: "magnifyingglass", description: Text("Type to search projects, blog posts, and about content."))
            } else if results.isEmpty {
                ContentUnavailableView("No results found.", systemImage: "magnifyingglass")
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
