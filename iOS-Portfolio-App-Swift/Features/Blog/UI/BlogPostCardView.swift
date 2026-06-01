import SwiftUI

struct BlogPostCardView: View {
    let post: BlogPost

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RemoteImageView(url: post.coverImageUrl)
                .scaledToFill()
                .frame(height: 170)
                .clipped()
                .accessibilityLabel(post.imageAlt)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Pill(post.category)
                    Spacer()
                    Text(post.readTime)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.secondaryText)
                }
                Text(post.title)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color.primaryText)
                Text(post.excerpt)
                    .foregroundStyle(Color.secondaryText)
                    .lineLimit(3)
                Text(post.date)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(Color.brandPrimary)
            }
            .padding(14)
        }
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
    }
}
