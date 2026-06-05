import SwiftUI

struct BlogDetailView: View {
    @State private var viewModel: BlogDetailViewModel

    init(initialPost: BlogPost, service: any PortfolioService) {
        _viewModel = State(initialValue: BlogDetailViewModel(initialPost: initialPost, service: service))
    }

    var body: some View {
        let selectedPost = viewModel.selectedPost

        GeometryReader { proxy in
            let contentWidth = max(proxy.size.width - 36, 0)

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    RemoteImageView(url: selectedPost.coverImageUrl)
                        .scaledToFill()
                        .frame(width: contentWidth, height: 230)
                        .clipped()
                        .accessibilityLabel(selectedPost.imageAlt)

                    VStack(alignment: .leading, spacing: 12) {
                        BlogBylineView(post: selectedPost)
                        BlogMetadataRow(post: selectedPost)
                        Text(selectedPost.title)
                            .font(.largeTitle.weight(.bold))
                            .foregroundStyle(Color.primaryText)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(selectedPost.excerpt)
                            .font(.body)
                            .lineSpacing(5)
                            .foregroundStyle(Color.secondaryText)
                            .fixedSize(horizontal: false, vertical: true)
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.brandPrimary)
                        }
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .font(.caption)
                                .foregroundStyle(Color.secondaryText)
                                .padding(10)
                                .background(Color.headerBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                    }
                    .frame(width: contentWidth, alignment: .leading)

                    if !selectedPost.content.isEmpty {
                        BlogContentBlocks(blocks: selectedPost.content.contentBlocks, contentWidth: contentWidth)
                    } else {
                        ForEach(selectedPost.sections) { section in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(section.title)
                                    .font(.title3.weight(.bold))
                                    .foregroundStyle(Color.primaryText)
                                    .fixedSize(horizontal: false, vertical: true)
                                BlogContentBlocks(blocks: section.content.contentBlocks, contentWidth: contentWidth)
                            }
                            .frame(width: contentWidth, alignment: .leading)
                        }
                    }

                    if !selectedPost.tags.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Tags")
                                .font(.headline)
                                .foregroundStyle(Color.primaryText)
                            FlowLayout(items: selectedPost.tags) { tag in
                                Pill(tag)
                            }
                        }
                        .frame(width: contentWidth, alignment: .leading)
                    }

                }
                .frame(width: contentWidth, alignment: .leading)
                .padding(18)
                .padding(.bottom, 96)
            }
        }
        .background(Color.appBackground)
        .navigationTitle("Blog")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadIfNeeded()
        }
    }
}

private struct BlogMetadataRow: View {
    let post: BlogPost

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Pill(post.category)
            Text(post.date)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.secondaryText)
                .lineLimit(1)
            Text("|")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.secondaryText.opacity(0.7))
            Text(post.readTime)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.secondaryText)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct BlogBylineView: View {
    let post: BlogPost

    var body: some View {
        HStack(spacing: 10) {
            if let authorAvatarUrl = post.authorAvatarUrl {
                RemoteImageView(url: authorAvatarUrl)
                    .scaledToFill()
                    .frame(width: 38, height: 38)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 38))
                    .foregroundStyle(Color.secondaryText)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(post.author)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.primaryText)
            }
        }
    }
}
