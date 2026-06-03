import SwiftUI

struct ProjectCardView: View {
    let project: Project
    let contentWidth: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RemoteImageView(url: project.coverImage)
                .scaledToFill()
                .frame(width: contentWidth, height: 178)
                .clipped()
                .accessibilityLabel(project.imageDescription)

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Pill(project.header)
                    Spacer()
                    Text("\(project.start) - \(project.end)")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color.brandPrimary)
                }

                Text(project.subtitle)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color.primaryText)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                Text(project.text)
                    .font(.body)
                    .foregroundStyle(Color.secondaryText)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)

                FlowLayout(items: Array(project.techStacks.prefix(3))) { tech in
                    Pill(tech)
                }
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
