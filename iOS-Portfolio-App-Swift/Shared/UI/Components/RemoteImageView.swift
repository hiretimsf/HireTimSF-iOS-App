import SwiftUI

struct RemoteImageView: View {
    let url: URL

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
            case .failure:
                ZStack {
                    Color.gray.opacity(0.18)
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundStyle(Color.secondaryText)
                }
            case .empty:
                ZStack {
                    Color.gray.opacity(0.14)
                    ProgressView()
                }
            @unknown default:
                Color.gray.opacity(0.14)
            }
        }
    }
}
