import SwiftUI

struct RichMarkdownText: View {
    let text: String
    var font: Font = .body
    var foregroundColor: Color = .secondaryText
    var lineSpacing: CGFloat = 5

    var body: some View {
        Text(attributedText)
            .font(font)
            .lineSpacing(lineSpacing)
            .fixedSize(horizontal: false, vertical: true)
    }

    private var attributedText: AttributedString {
        var attributed = (
            try? AttributedString(
                markdown: text.normalizedMarkdownBody,
                options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
            )
        ) ?? AttributedString(text)
        attributed.foregroundColor = foregroundColor

        for run in attributed.runs where run.link != nil {
            attributed[run.range].foregroundColor = .brandPrimary
        }

        return attributed
    }
}

private extension String {
    var normalizedMarkdownBody: String {
        replacingOccurrences(
            of: #"\]\((/[^)]+)\)"#,
            with: "](https://hiretimsf.com$1)",
            options: .regularExpression
        )
        .replacingOccurrences(
            of: #"\n[ \t]*\n[ \t]*"#,
            with: "\n\n",
            options: .regularExpression
        )
        .replacingOccurrences(
            of: #"[ \t]+\n"#,
            with: "\n",
            options: .regularExpression
        )
    }
}
