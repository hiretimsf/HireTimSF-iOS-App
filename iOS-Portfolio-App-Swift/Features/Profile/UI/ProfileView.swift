import SwiftUI
import Observation

struct ProfileView: View {
    @State private var viewModel: ProfileViewModel

    init(service: any PortfolioService) {
        _viewModel = State(initialValue: ProfileViewModel(service: service))
    }

    var body: some View {
        let aboutContent = viewModel.aboutContent

        ScrollView {
            VStack(spacing: 0) {
                ProfileHeaderView()

                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(Array(aboutContent.sections.enumerated()), id: \.element.id) { index, section in
                        AboutSectionView(section: section)
                        if index == 0 {
                            AboutPhotoCarousel(photos: aboutContent.photos)
                        }
                    }
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 24)
            }
        }
        .background(Color.appBackground)
        .task {
            await viewModel.loadIfNeeded()
        }
    }
}

@MainActor
@Observable
private final class ProfileViewModel {
    private let service: any PortfolioService

    var aboutContent = PortfolioData.aboutContent
    var isLoading = false

    init(service: any PortfolioService) {
        self.service = service
    }

    func loadIfNeeded() async {
        guard !isLoading else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            aboutContent = try await service.loadAboutContent()
        } catch is CancellationError {
        } catch {
            aboutContent = PortfolioData.aboutContent
        }
    }
}
