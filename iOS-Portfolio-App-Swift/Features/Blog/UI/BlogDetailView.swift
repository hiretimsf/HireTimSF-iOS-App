import SwiftUI

struct BlogDetailView: View {
    @Environment(PortfolioViewModel.self) private var portfolio
    @State private var viewModel: BlogDetailViewModel

    init(initialPost: BlogPost) {
        _viewModel = State(initialValue: BlogDetailViewModel(initialPost: initialPost))
    }

    var body: some View {
        let selectedPost = viewModel.selectedPost

        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                RemoteImageView(url: selectedPost.coverImageUrl)
                    .scaledToFill()
                    .frame(height: 230)
                    .clipped()
                    .accessibilityLabel(selectedPost.imageAlt)

                VStack(alignment: .leading, spacing: 12) {
                    Pill(selectedPost.category)
                    Text(selectedPost.title)
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(Color.primaryText)
                    Text("\(selectedPost.date)  |  \(selectedPost.readTime)")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color.headerTitle)
                    Text(selectedPost.excerpt)
                        .font(.body)
                        .lineSpacing(5)
                        .foregroundStyle(Color.secondaryText)
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
                .padding(.horizontal, 18)

                ForEach(selectedPost.sections) { section in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(section.title)
                            .font(.title3.weight(.bold))
                            .foregroundStyle(Color.primaryText)
                        BlogContentBlocks(blocks: section.content.contentBlocks)
                    }
                    .padding(.horizontal, 18)
                }

                if selectedPost.sections.isEmpty && !selectedPost.content.isEmpty {
                    BlogContentBlocks(blocks: selectedPost.content.contentBlocks)
                        .padding(.horizontal, 18)
                }

                if let url = selectedPost.url {
                    Link(destination: url) {
                        Label("Open on hiretimsf.com", systemImage: "safari")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.brandPrimary)
                    .padding(.horizontal, 18)
                    .padding(.bottom, 20)
                }
            }
        }
        .background(Color.appBackground)
        .navigationTitle("Blog")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadIfNeeded(using: portfolio)
        }
    }
}
