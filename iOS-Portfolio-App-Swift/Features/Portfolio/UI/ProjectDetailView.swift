import SwiftUI

struct ProjectDetailView: View {
    let project: Project

    var body: some View {
        GeometryReader { proxy in
            let contentWidth = max(proxy.size.width - 36, 0)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    RemoteImageView(url: project.coverImage)
                        .scaledToFill()
                        .frame(width: contentWidth, height: 260)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .accessibilityLabel(project.imageDescription)

                    VStack(alignment: .leading, spacing: 10) {
                        Pill(project.header)
                        Text(project.subtitle)
                            .font(.largeTitle.weight(.bold))
                            .fixedSize(horizontal: false, vertical: true)
                        Text("\(project.start) - \(project.end)")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.brandPrimary)
                        Text(project.text)
                            .font(.body)
                            .lineSpacing(5)
                            .foregroundStyle(Color.secondaryText)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(width: contentWidth, alignment: .leading)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Tech Stacks")
                            .font(.headline)
                        FlowLayout(items: project.techStacks) { tech in
                            Pill(tech)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(width: contentWidth, alignment: .leading)

                    VStack(spacing: 10) {
                        ForEach(project.links) { link in
                            Link(destination: link.url) {
                                CardActionLabel(title: link.title)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .frame(width: contentWidth)
                }
                .frame(width: contentWidth, alignment: .leading)
                .padding(18)
                .padding(.bottom, 96)
            }
        }
        .background(Color.appBackground)
        .navigationTitle(project.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
