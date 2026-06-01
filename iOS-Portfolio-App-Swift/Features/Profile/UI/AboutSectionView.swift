import SwiftUI

struct AboutSectionView: View {
    let section: AboutSection

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(section.title)
                .font(.title3.weight(.bold))
                .foregroundStyle(Color.primaryText)
            Text(section.content)
                .font(.body)
                .lineSpacing(5)
                .foregroundStyle(Color.secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
