import SwiftUI

struct BlogPostCardView: View {
    let post: BlogPost
    let contentWidth: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RemoteImageView(url: post.coverImageUrl)
                .scaledToFill()
                .frame(width: contentWidth, height: 170)
                .clipped()
                .accessibilityLabel(post.imageAlt)

            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 10) {
                    Pill(post.category)
                    Text(post.date)
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color.secondaryText)
                    Text("|")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color.secondaryText.opacity(0.7))
                    Text(post.readTime)
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color.secondaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Text(post.title)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color.primaryText)
                    .fixedSize(horizontal: false, vertical: true)
                Text(post.excerpt)
                    .foregroundStyle(Color.secondaryText)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)

                CardActionLabel(title: "Read More")
            }
            .padding(14)
            .frame(width: contentWidth, alignment: .leading)
        }
        .frame(width: contentWidth, alignment: .leading)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
    }
}
