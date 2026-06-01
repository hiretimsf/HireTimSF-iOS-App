import SwiftUI

struct ProjectDetailView: View {
    let project: Project

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                RemoteImageView(url: project.coverImage)
                    .scaledToFill()
                    .frame(height: 260)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .accessibilityLabel(project.imageDescription)

                VStack(alignment: .leading, spacing: 10) {
                    Pill(project.header)
                    Text(project.subtitle)
                        .font(.largeTitle.weight(.bold))
                    Text("\(project.start) - \(project.end)")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color.brandPrimary)
                    Text(project.text)
                        .font(.body)
                        .lineSpacing(5)
                        .foregroundStyle(Color.secondaryText)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Tech")
                        .font(.headline)
                    FlowLayout(items: project.techStacks) { tech in
                        Pill(tech)
                    }
                }

                VStack(spacing: 10) {
                    ForEach(project.links) { link in
                        Link(destination: link.url) {
                            Label(link.title, systemImage: link.systemImage)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.brandPrimary)
                    }
                }
            }
            .padding(18)
        }
        .background(Color.appBackground)
        .navigationTitle(project.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
