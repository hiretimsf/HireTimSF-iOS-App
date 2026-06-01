import SwiftUI

struct BlogView: View {
    @Environment(PortfolioViewModel.self) private var portfolio

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Blog")
                        .font(.largeTitle.weight(.bold))
                    Text("Latest posts from hiretimsf.com.")
                        .foregroundStyle(Color.secondaryText)
                    if portfolio.isLoadingBlogPosts {
                        ProgressView()
                            .tint(.brandPrimary)
                            .padding(.top, 6)
                    }
                    if let blogError = portfolio.blogError {
                        Text(blogError)
                            .font(.caption)
                            .foregroundStyle(Color.secondaryText)
                            .padding(10)
                            .background(Color.headerBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                }
                .padding(.vertical, 10)
            }
            .listRowBackground(Color.clear)

            ForEach(portfolio.blogPosts) { post in
                NavigationLink {
                    BlogDetailView(initialPost: post)
                } label: {
                    BlogPostCardView(post: post)
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.appBackground)
        .refreshable {
            await portfolio.loadBlogPosts()
        }
    }
}
