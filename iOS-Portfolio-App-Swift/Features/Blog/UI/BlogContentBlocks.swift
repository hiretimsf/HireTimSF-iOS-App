import SwiftUI

struct BlogContentBlocks: View {
    let blocks: [BlogContentBlock]
    let contentWidth: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(blocks) { block in
                switch block {
                case .heading(let level, let title):
                    Text(title)
                        .font(level == 1 ? .title2.weight(.bold) : .title3.weight(.bold))
                        .foregroundStyle(Color.primaryText)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, level == 1 ? 8 : 4)
                case .text(let text):
                    RichMarkdownText(text: text)
                case .image(let image):
                    BlogImageCard(image: image)
                        .frame(width: contentWidth, height: contentWidth * 10 / 16)
                case .imageCarousel(let images):
                    BlogImageCarousel(images: images, contentWidth: contentWidth)
                case .video(let title, let url):
                    VideoLinkCard(title: title, embedURL: url)
                        .frame(width: contentWidth, height: contentWidth * 9 / 16)
                }
            }
        }
        .frame(width: contentWidth, alignment: .leading)
    }
}

private struct BlogImageCarousel: View {
    let images: [BlogImage]
    let contentWidth: CGFloat

    @State private var selected = 0

    var body: some View {
        VStack(spacing: 10) {
            TabView(selection: $selected) {
                ForEach(Array(images.enumerated()), id: \.element.id) { index, image in
                    BlogImageCard(image: image)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: contentWidth, height: contentWidth * 10 / 16)

            HStack(spacing: 12) {
                Button(action: showPrevious) {
                    Image(systemName: "chevron.left")
                        .font(.subheadline.weight(.bold))
                        .frame(width: 36, height: 36)
                }
                .buttonStyle(.plain)
                .foregroundStyle(Color.brandPrimary)
                .background(Color.brandPrimary.opacity(0.12), in: Circle())
                .accessibilityLabel("Previous image")

                Spacer()

                HStack(spacing: 8) {
                    ForEach(images.indices, id: \.self) { index in
                        Circle()
                            .fill(index == selected ? Color.brandPrimary : Color.secondaryText.opacity(0.28))
                            .frame(width: index == selected ? 9 : 7, height: index == selected ? 9 : 7)
                    }
                }
                .frame(minWidth: 72)

                Spacer()

                Button(action: showNext) {
                    Image(systemName: "chevron.right")
                        .font(.subheadline.weight(.bold))
                        .frame(width: 36, height: 36)
                }
                .buttonStyle(.plain)
                .foregroundStyle(Color.brandPrimary)
                .background(Color.brandPrimary.opacity(0.12), in: Circle())
                .accessibilityLabel("Next image")
            }
            .padding(.horizontal, 4)
        }
        .frame(width: contentWidth)
        .accessibilityLabel("Image carousel with \(images.count) images")
    }

    private func showPrevious() {
        guard !images.isEmpty else { return }
        withAnimation(.easeOut(duration: 0.2)) {
            selected = selected == 0 ? images.count - 1 : selected - 1
        }
    }

    private func showNext() {
        guard !images.isEmpty else { return }
        withAnimation(.easeOut(duration: 0.2)) {
            selected = selected == images.count - 1 ? 0 : selected + 1
        }
    }
}

private struct BlogImageCard: View {
    let image: BlogImage

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.headerBackground

            RemoteImageView(url: image.url.absoluteBlogImageURL)
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

            if let caption = image.caption {
                LinearGradient(
                    colors: [.clear, .black.opacity(0.58)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(maxHeight: .infinity)

                Text(caption)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .padding(12)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color.headerBackground, lineWidth: 1)
        }
        .accessibilityLabel(image.alt)
    }
}

private struct VideoLinkCard: View {
    let title: String
    let embedURL: URL

    private var video: YouTubeVideo? {
        YouTubeVideo(url: embedURL)
    }

    private var destination: URL {
        video?.watchURL ?? embedURL
    }

    var body: some View {
        Link(destination: destination) {
            ZStack {
                if let thumbnailURL = video?.thumbnailURL {
                    RemoteImageView(url: thumbnailURL)
                        .scaledToFill()
                } else {
                    Rectangle()
                        .fill(Color.headerBackground)
                }

                LinearGradient(
                    colors: [.black.opacity(0.1), .black.opacity(0.55)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                Image(systemName: "play.fill")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.white)
                    .frame(width: 62, height: 62)
                    .background(.black.opacity(0.55), in: Circle())
                    .overlay {
                        Circle()
                            .stroke(.white.opacity(0.75), lineWidth: 1)
                    }

                VStack {
                    Spacer()
                    HStack {
                        Text(title)
                            .font(.headline.weight(.bold))
                            .foregroundStyle(.white)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(14)
                }
            }
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.headerBackground, lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Open video: \(title)")
    }
}

private struct YouTubeVideo {
    let id: String
    let startSeconds: Int?

    init?(url: URL) {
        guard let id = Self.videoID(from: url) else { return nil }
        self.id = id
        startSeconds = Self.startSeconds(from: url)
    }

    var thumbnailURL: URL? {
        URL(string: "https://img.youtube.com/vi/\(id)/hqdefault.jpg")
    }

    var watchURL: URL {
        var components = URLComponents(string: "https://www.youtube.com/watch")
        components?.queryItems = [
            URLQueryItem(name: "v", value: id)
        ]
        if let startSeconds {
            components?.queryItems?.append(URLQueryItem(name: "t", value: "\(startSeconds)s"))
        }
        return components?.url ?? URL(string: "https://www.youtube.com/watch?v=\(id)")!
    }

    private static func videoID(from url: URL) -> String? {
        if url.host()?.contains("youtu.be") == true {
            return url.pathComponents.dropFirst().first
        }

        if let embedIndex = url.pathComponents.firstIndex(of: "embed"),
           url.pathComponents.indices.contains(embedIndex + 1) {
            return url.pathComponents[embedIndex + 1]
        }

        return URLComponents(url: url, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first(where: { $0.name == "v" })?
            .value
    }

    private static func startSeconds(from url: URL) -> Int? {
        let value = URLComponents(url: url, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first(where: { $0.name == "start" || $0.name == "t" })?
            .value

        guard let value else { return nil }
        if let seconds = Int(value.trimmingCharacters(in: CharacterSet(charactersIn: "s"))) {
            return seconds
        }

        let pattern = #"(?:(\d+)h)?(?:(\d+)m)?(?:(\d+)s)?"#
        guard
            let regex = try? NSRegularExpression(pattern: pattern),
            let match = regex.firstMatch(in: value, range: NSRange(location: 0, length: (value as NSString).length))
        else { return nil }

        let nsValue = value as NSString
        let hours = match.integerValue(at: 1, in: nsValue)
        let minutes = match.integerValue(at: 2, in: nsValue)
        let seconds = match.integerValue(at: 3, in: nsValue)
        let total = hours * 3600 + minutes * 60 + seconds
        return total > 0 ? total : nil
    }
}

private extension NSTextCheckingResult {
    func integerValue(at index: Int, in string: NSString) -> Int {
        guard range(at: index).location != NSNotFound else { return 0 }
        return Int(string.substring(with: range(at: index))) ?? 0
    }
}
