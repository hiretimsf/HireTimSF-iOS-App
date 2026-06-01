import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ProfileHeaderView()

                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(Array(PortfolioData.aboutSections.enumerated()), id: \.element.id) { index, section in
                        AboutSectionView(section: section)
                        if index == 0 {
                            AboutPhotoCarousel()
                        }
                    }
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 24)
            }
        }
        .background(Color.appBackground)
    }
}
