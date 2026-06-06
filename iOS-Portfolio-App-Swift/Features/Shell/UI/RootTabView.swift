import SwiftUI

struct RootTabView: View {
    let portfolioViewModel: PortfolioViewModel
    let appEnvironment: AppEnvironment

    @State private var viewModel: RootTabViewModel

    @MainActor
    init(
        portfolioViewModel: PortfolioViewModel,
        appEnvironment: AppEnvironment
    ) {
        self.portfolioViewModel = portfolioViewModel
        self.appEnvironment = appEnvironment
        _viewModel = State(initialValue: RootTabViewModel())
    }

    var body: some View {
        @Bindable var model = viewModel

        ZStack(alignment: .leading) {
            TabView(selection: $model.selectedTab) {
                AppNavigation(title: "Profile", showingDrawer: $model.isShowingDrawer, showingContact: $model.isShowingContact, showingSearch: $model.isShowingSearch) {
                    ProfileView(service: appEnvironment.portfolioService)
                }
                .tabItem {
                    Image(systemName: AppTab.profile.systemImage)
                    Text("Profile")
                }
                .tag(AppTab.profile)

                AppNavigation(title: "Portfolio", showingDrawer: $model.isShowingDrawer, showingContact: $model.isShowingContact, showingSearch: $model.isShowingSearch) {
                    PortfolioView(viewModel: portfolioViewModel)
                }
                .tabItem {
                    Image(systemName: AppTab.portfolio.systemImage)
                    Text("Portfolio")
                }
                .tag(AppTab.portfolio)

                AppNavigation(title: "Blog", showingDrawer: $model.isShowingDrawer, showingContact: $model.isShowingContact, showingSearch: $model.isShowingSearch) {
                    BlogView(
                        viewModel: portfolioViewModel,
                        service: appEnvironment.portfolioService
                    )
                }
                .tabItem {
                    Image(systemName: AppTab.blog.systemImage)
                    Text("Blog")
                }
                .tag(AppTab.blog)

                AppNavigation(title: "Settings", showingDrawer: $model.isShowingDrawer, showingContact: $model.isShowingContact, showingSearch: $model.isShowingSearch) {
                    SettingsView()
                }
                .tabItem {
                    Image(systemName: AppTab.settings.systemImage)
                    Text("Settings")
                }
                .tag(AppTab.settings)
            }
            .tint(.brandPrimary)

            if model.isShowingDrawer {
                Button {
                    withAnimation(.easeOut(duration: 0.2)) { model.isShowingDrawer = false }
                } label: {
                    Color.black.opacity(0.28)
                        .ignoresSafeArea()
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Close navigation menu")
                .accessibilityHint("Dismisses the navigation drawer")
                NavigationDrawer(
                    selectedTab: $model.selectedTab,
                    showingDrawer: $model.isShowingDrawer,
                    showingContact: $model.isShowingContact
                )
                .transition(.move(edge: .leading))
            }
        }
        .onChange(of: model.selectedTab) {
            if model.isShowingDrawer {
                withAnimation(.easeOut(duration: 0.2)) { model.isShowingDrawer = false }
            }
        }
        .animation(.easeOut(duration: 0.22), value: model.isShowingDrawer)
        .sheet(isPresented: $model.isShowingContact) {
            NavigationStack { ContactView() }
        }
        .sheet(isPresented: $model.isShowingSearch) {
            NavigationStack {
                SearchView(portfolioViewModel: portfolioViewModel)
            }
        }
    }
}
