import SwiftUI

struct RootTabView: View {
    @State private var viewModel = RootTabViewModel()

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
                    PortfolioView()
                }
                .tabItem { Label("Portfolio", systemImage: "rectangle.stack") }
                .tag(AppTab.portfolio)

                AppNavigation(title: "Blog", showingDrawer: $model.isShowingDrawer, showingContact: $model.isShowingContact, showingSearch: $model.isShowingSearch) {
                    BlogView()
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
                Color.black.opacity(0.28)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) { model.isShowingDrawer = false }
                    }
                NavigationDrawer(
                    selectedTab: $model.selectedTab,
                    showingDrawer: $model.isShowingDrawer,
                    showingContact: $model.isShowingContact
                )
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeOut(duration: 0.22), value: model.isShowingDrawer)
        .sheet(isPresented: $model.isShowingContact) {
            NavigationStack { ContactView() }
        }
        .sheet(isPresented: $model.isShowingSearch) {
            NavigationStack { SearchView() }
        }
    }
}
