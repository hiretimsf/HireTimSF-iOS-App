import SwiftUI

struct OnboardingView: View {
    @State private var viewModel = OnboardingViewModel()
    let onFinish: () -> Void

    var body: some View {
        @Bindable var viewModel = viewModel

        VStack(spacing: 0) {
            TabView(selection: $viewModel.selectedPageIndex) {
                ForEach(Array(viewModel.pages.enumerated()), id: \.element.id) { index, page in
                    WelcomePageView(page: page)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            OnboardingPageIndicator(
                count: viewModel.pages.count,
                selectedIndex: viewModel.selectedPageIndex
            )
            .padding(.bottom, 18)

            Button {
                if viewModel.isLastPage {
                    onFinish()
                } else {
                    withAnimation(.easeInOut) {
                        _ = viewModel.advance()
                    }
                }
            } label: {
                Text(viewModel.primaryButtonTitle)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .buttonStyle(.borderedProminent)
            .tint(.brandPrimary)
            .padding(.horizontal, 24)
            .padding(.bottom, 28)
        }
        .background(Color.appBackground)
    }
}
