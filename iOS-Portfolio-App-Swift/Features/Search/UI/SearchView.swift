import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(PortfolioViewModel.self) private var portfolio
    @State private var viewModel = SearchViewModel()

    var body: some View {
        @Bindable var viewModel = viewModel
        let results = viewModel.results(projects: portfolio.projects, blogPosts: portfolio.blogPosts)

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
