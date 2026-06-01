import Foundation

enum BlogContentBlock: Identifiable {
    case text(String)
    case image(alt: String, url: String)

    var id: String {
        switch self {
        case .text(let text): "text-\(text.hashValue)"
        case .image(let alt, let url): "image-\(alt)-\(url)"
        }
    }
}

extension String {
    var contentBlocks: [BlogContentBlock] {
        let pattern = #"!\[([\s\S]*?)\]\(([^)]+)\)"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [.text(self)] }
        let nsString = self as NSString
        let matches = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
        var blocks: [BlogContentBlock] = []
        var cursor = 0

        for match in matches {
            if match.range.location > cursor {
                let text = nsString
                    .substring(with: NSRange(location: cursor, length: match.range.location - cursor))
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                if !text.isEmpty { blocks.append(.text(text)) }
            }

            let alt = nsString
                .substring(with: match.range(at: 1))
                .replacingOccurrences(of: #"\s+"#, with: " ", options: .regularExpression)
            let url = nsString
                .substring(with: match.range(at: 2))
                .trimmingCharacters(in: .whitespacesAndNewlines)

            if !url.isEmpty { blocks.append(.image(alt: alt, url: url)) }
            cursor = match.range.location + match.range.length
        }

        if cursor < nsString.length {
            let text = nsString.substring(from: cursor).trimmingCharacters(in: .whitespacesAndNewlines)
            if !text.isEmpty { blocks.append(.text(text)) }
        }

        return blocks.isEmpty ? [.text(self)] : blocks
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
