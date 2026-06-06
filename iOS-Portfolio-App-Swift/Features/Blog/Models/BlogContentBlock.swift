import Foundation

struct BlogImage: Identifiable {
    let alt: String
    let url: String
    let caption: String?

    var id: String { "\(alt)-\(url)" }
}

enum BlogContentBlock: Identifiable {
    case heading(level: Int, title: String)
    case text(String)
    case image(BlogImage)
    case imageCarousel([BlogImage])
    case video(title: String, url: URL)

    var id: String {
        switch self {
        case .heading(let level, let title): "heading-\(level)-\(title.hashValue)"
        case .text(let text): "text-\(text.hashValue)"
        case .image(let image): "image-\(image.id)"
        case .imageCarousel(let images): "carousel-\(images.map(\.id).joined(separator: "-"))"
        case .video(let title, let url): "video-\(title)-\(url.absoluteString)"
        }
    }
}

extension String {
    var contentBlocks: [BlogContentBlock] {
        let imagePattern = #"!\[([\s\S]*?)\]\(([^)]+)\)"#
        let videoPattern = #"<div[\s\S]*?<iframe[\s\S]*?(?:</iframe>|/>)[\s\S]*?</div>|<iframe[\s\S]*?(?:</iframe>|/>)"#
        guard
            let imageRegex = try? NSRegularExpression(pattern: imagePattern),
            let videoRegex = try? NSRegularExpression(pattern: videoPattern, options: [.caseInsensitive])
        else { return [.text(self)] }

        let nsString = self as NSString
        let searchRange = NSRange(location: 0, length: nsString.length)
        let imageMatches = imageRegex.matches(in: self, range: searchRange).compactMap { match -> ContentMatch? in
            let alt = nsString
                .substring(with: match.range(at: 1))
                .replacingOccurrences(of: #"\s+"#, with: " ", options: .regularExpression)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let url = nsString
                .substring(with: match.range(at: 2))
                .trimmingCharacters(in: .whitespacesAndNewlines)
            guard !url.isEmpty else { return nil }
            return ContentMatch(range: match.range, block: .image(BlogImage(alt: alt, url: url, caption: nil)))
        }
        let videoMatches = videoRegex.matches(in: self, range: searchRange).compactMap { match -> ContentMatch? in
            let html = nsString.substring(with: match.range)
            guard
                let source = html.htmlAttribute("src"),
                let url = URL(string: source)
            else { return nil }
            let title = html.htmlAttribute("title") ?? "Embedded video"
            return ContentMatch(range: match.range, block: .video(title: title, url: url))
        }
        let matches = (imageMatches + videoMatches).sorted { $0.range.location < $1.range.location }
        var blocks: [BlogContentBlock] = []
        var cursor = 0

        for match in matches {
            guard match.range.location >= cursor else { continue }

            if match.range.location > cursor {
                let text = nsString
                    .substring(with: NSRange(location: cursor, length: match.range.location - cursor))
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                if !text.attachAsCaptionIfPossible(to: &blocks) {
                    text.appendTextBlocks(to: &blocks)
                }
            }

            blocks.append(match.block)
            cursor = match.range.location + match.range.length
        }

        if cursor < nsString.length {
            let text = nsString.substring(from: cursor).trimmingCharacters(in: .whitespacesAndNewlines)
            if !text.attachAsCaptionIfPossible(to: &blocks) {
                text.appendTextBlocks(to: &blocks)
            }
        }

        return blocks.isEmpty ? [.text(self)] : blocks.coalescingImageCarousels()
    }

    var absoluteBlogImageURL: URL {
        if let url = URL(string: self), url.scheme != nil {
            return url
        }
        if hasPrefix("/") {
            return URL(string: "https://hiretimsf.com\(self)") ?? PortfolioData.fallbackImageURL
        }
        return URL(string: "https://hiretimsf.com/\(self)") ?? PortfolioData.fallbackImageURL
    }

    var displayMarkdownText: String {
        replacingOccurrences(of: #"^#{1,6}\s*"#, with: "", options: .regularExpression)
            .replacingOccurrences(of: #"\[([^\]]+)\]\(([^)]+)\)"#, with: "$1", options: .regularExpression)
            .replacingOccurrences(of: #"\n{3,}"#, with: "\n\n", options: .regularExpression)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

private struct ContentMatch {
    let range: NSRange
    let block: BlogContentBlock
}

private extension String {
    func attachAsCaptionIfPossible(to blocks: inout [BlogContentBlock]) -> Bool {
        let caption = captionText
        guard
            let caption,
            let last = blocks.indices.last,
            case .image(let image) = blocks[last]
        else { return false }

        blocks[last] = .image(BlogImage(alt: image.alt, url: image.url, caption: caption))
        return true
    }

    var captionText: String? {
        let text = displayMarkdownText
        guard !text.isEmpty else { return nil }
        guard !text.contains("\n\n"), text.count <= 180 else { return nil }
        guard !text.contains("://"), !text.contains("](") else { return nil }
        return text
            .split(separator: "\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }

    func appendTextBlocks(to blocks: inout [BlogContentBlock]) {
        let text = trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        let pattern = #"(?m)^\s{0,3}(#{1,3})\s+(.+?)\s*$"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            blocks.append(.text(text))
            return
        }

        let nsString = text as NSString
        let matches = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
        var cursor = 0

        for match in matches {
            if match.range.location > cursor {
                let preceding = nsString
                    .substring(with: NSRange(location: cursor, length: match.range.location - cursor))
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                if !preceding.isEmpty { blocks.append(.text(preceding)) }
            }

            let level = nsString.substring(with: match.range(at: 1)).count
            let title = nsString
                .substring(with: match.range(at: 2))
                .displayMarkdownText
            blocks.append(.heading(level: level, title: title))
            cursor = match.range.location + match.range.length
        }

        if cursor < nsString.length {
            let trailing = nsString.substring(from: cursor).trimmingCharacters(in: .whitespacesAndNewlines)
            if !trailing.isEmpty { blocks.append(.text(trailing)) }
        }

        if matches.isEmpty {
            blocks.append(.text(text))
        }
    }

    func htmlAttribute(_ name: String) -> String? {
        let pattern = #"\#(name)\s*=\s*["']([^"']+)["']"#
        guard let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) else { return nil }
        let nsString = self as NSString
        guard let match = regex.firstMatch(in: self, range: NSRange(location: 0, length: nsString.length)) else { return nil }
        return nsString.substring(with: match.range(at: 1))
    }
}

private extension Array where Element == BlogContentBlock {
    func coalescingImageCarousels() -> [BlogContentBlock] {
        var result: [BlogContentBlock] = []
        var imageRun: [BlogImage] = []

        func flushRun() {
            guard !imageRun.isEmpty else { return }
            if imageRun.count > 1 {
                result.append(.imageCarousel(imageRun))
            } else if let image = imageRun.first {
                result.append(.image(image))
            }
            imageRun.removeAll()
        }

        for block in self {
            switch block {
            case .image(let image):
                imageRun.append(image)
            default:
                flushRun()
                result.append(block)
            }
        }

        flushRun()
        return result
    }
}
