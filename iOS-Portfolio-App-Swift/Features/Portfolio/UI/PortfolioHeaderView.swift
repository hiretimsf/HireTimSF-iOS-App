import SwiftUI

struct PortfolioHeaderView: View {
    let isLoading: Bool
    let errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Portfolio")
                .font(.largeTitle.weight(.bold))
            Text("Selected Android and web projects from Tim Baz.")
                .foregroundStyle(Color.secondaryText)
            if isLoading {
                ProgressView()
                    .tint(.brandPrimary)
                    .padding(.top, 6)
            }
            if let errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(Color.secondaryText)
                    .padding(10)
                    .background(Color.headerBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
    }
}
