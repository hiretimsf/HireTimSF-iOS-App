import SwiftUI

struct ProjectCardView: View {
    let project: Project
    let contentWidth: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                RemoteImageView(url: project.coverImage)
                    .scaledToFill()
                    .frame(width: contentWidth, height: 188)
                    .clipped()
                    .accessibilityLabel(project.imageDescription)

                LinearGradient(
                    colors: [.clear, .black.opacity(0.55)],
                    startPoint: .center,
                    endPoint: .bottom
                )

                HStack(alignment: .bottom, spacing: 12) {
                    if let logo = project.logo {
                        RemoteImageView(url: logo)
                            .scaledToFit()
                            .frame(width: 46, height: 46)
                            .padding(6)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(project.header)
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.white.opacity(0.86))
                        Text(project.title)
                            .font(.title3.weight(.bold))
                            .foregroundStyle(.white)
                            .lineLimit(2)
                    }
                }
                .padding(14)
            }
            .frame(width: contentWidth, height: 188)

            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Pill(project.header)
                    Text("\(project.start) - \(project.end)")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color.secondaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

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
                .frame(maxWidth: .infinity, alignment: .leading)

                PrimaryActionLabel(title: "Learn More")
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
