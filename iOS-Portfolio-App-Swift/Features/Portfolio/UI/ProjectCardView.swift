import SwiftUI

struct ProjectCardView: View {
    let project: Project

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RemoteImageView(url: project.coverImage)
                .scaledToFill()
                .frame(height: 178)
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

                Text(project.text)
                    .font(.body)
                    .foregroundStyle(Color.secondaryText)
                    .lineLimit(3)

                HStack {
                    ForEach(project.techStacks.prefix(3), id: \.self) { Pill($0) }
                    Spacer(minLength: 0)
                }
            }
            .padding(14)
        }
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
    }
}
