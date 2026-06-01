import Observation

@MainActor
@Observable
final class RootTabViewModel {
    var selectedTab: AppTab = .profile
    var isShowingContact = false
    var isShowingSearch = false
    var isShowingDrawer = false

    func selectTab(_ tab: AppTab) {
        selectedTab = tab
        isShowingDrawer = false
    }

    func showContact() {
        isShowingDrawer = false
        isShowingContact = true
    }
}
