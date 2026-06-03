import SwiftUI

struct BlogView: View {
    let viewModel: PortfolioViewModel
    let service: any PortfolioService

    var body: some View {
        GeometryReader { proxy in
            let contentWidth = max(proxy.size.width - 36, 0)

            List {
                ForEach(viewModel.blogPosts) { post in
                    NavigationLink {
                        BlogDetailView(initialPost: post, service: service)
                    } label: {
                        BlogPostCardView(post: post, contentWidth: contentWidth)
                    }
                    .buttonStyle(.plain)
                    .listRowInsets(EdgeInsets(top: 8, leading: 18, bottom: 8, trailing: 18))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.appBackground)
            .refreshable {
                await viewModel.loadBlogPosts()
            }
        }
    }
}
