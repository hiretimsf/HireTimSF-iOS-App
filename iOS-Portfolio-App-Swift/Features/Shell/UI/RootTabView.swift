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
                    ProfileView()
                }
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(AppTab.profile)

                AppNavigation(title: "Portfolio", showingDrawer: $model.isShowingDrawer, showingContact: $model.isShowingContact, showingSearch: $model.isShowingSearch) {
                    PortfolioView(viewModel: portfolioViewModel)
                }
                .tabItem { Label("Portfolio", systemImage: "rectangle.stack") }
                .tag(AppTab.portfolio)

                AppNavigation(title: "Blog", showingDrawer: $model.isShowingDrawer, showingContact: $model.isShowingContact, showingSearch: $model.isShowingSearch) {
                    BlogView(
                        viewModel: portfolioViewModel,
                        service: appEnvironment.portfolioService
                    )
                }
                .tabItem { Label("Blog", systemImage: "text.alignleft") }
                .tag(AppTab.blog)

                AppNavigation(title: "Settings", showingDrawer: $model.isShowingDrawer, showingContact: $model.isShowingContact, showingSearch: $model.isShowingSearch) {
                    SettingsView()
                }
                .tabItem { Label("Settings", systemImage: "gearshape") }
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
