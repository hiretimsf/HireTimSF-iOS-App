import SwiftUI

struct BlogContentBlocks: View {
    let blocks: [BlogContentBlock]
    let contentWidth: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(blocks) { block in
                switch block {
                case .text(let text):
                    Text(text.displayMarkdownText)
                        .font(.body)
                        .lineSpacing(5)
                        .foregroundStyle(Color.secondaryText)
                        .fixedSize(horizontal: false, vertical: true)
                case .image(let alt, let url):
                    RemoteImageView(url: url.absoluteBlogImageURL)
                        .scaledToFill()
                        .frame(width: contentWidth)
                        .frame(minHeight: 190)
                        .aspectRatio(16 / 10, contentMode: .fit)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .accessibilityLabel(alt)
                }
            }
        }
        .frame(width: contentWidth, alignment: .leading)
    }
}
