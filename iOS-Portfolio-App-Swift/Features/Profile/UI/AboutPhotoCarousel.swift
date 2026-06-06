import SwiftUI

struct AboutPhotoCarousel: View {
    let photos: [AboutPhoto]

    @State private var selected = 0

    init(photos: [AboutPhoto] = PortfolioData.aboutPhotos) {
        self.photos = photos
    }

    var body: some View {
        TabView(selection: $selected) {
            ForEach(Array(photos.enumerated()), id: \.element.id) { index, photo in
                RemoteImageView(url: photo.url)
                    .scaledToFill()
                    .frame(height: 330)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .tag(index)
                    .accessibilityLabel(photo.alt)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .automatic))
        .frame(height: 330)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
