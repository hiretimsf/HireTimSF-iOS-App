import SwiftUI

struct BlogView: View {
    let viewModel: PortfolioViewModel
    let service: any PortfolioService
    @State private var selectedPostID: String?

    var body: some View {
        GeometryReader { proxy in
            let contentWidth = max(proxy.size.width - 36, 0)

            List {
                ForEach(viewModel.blogPosts) { post in
                    Button {
                        selectedPostID = post.id
                    } label: {
                        BlogPostCardView(post: post, contentWidth: contentWidth)
                    }
                    .buttonStyle(.plain)
                    .listRowInsets(EdgeInsets(top: 12, leading: 18, bottom: 12, trailing: 18))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.appBackground)
            .navigationDestination(item: $selectedPostID) { postID in
                if let post = viewModel.blogPosts.first(where: { $0.id == postID }) {
                    BlogDetailView(initialPost: post, service: service)
                }
            }
            .refreshable {
                await viewModel.loadBlogPosts()
            }
        }
    }
}
