import SwiftUI

struct AppNavigation<Content: View>: View {
    let title: String
    @Binding var showingDrawer: Bool
    @Binding var showingContact: Bool
    @Binding var showingSearch: Bool
    @ViewBuilder let content: Content

    var body: some View {
        NavigationStack {
            content
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation(.easeOut(duration: 0.2)) { showingDrawer = true }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                        }
                        .accessibilityLabel("Open navigation menu")
                    }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button { showingSearch = true } label: {
                            Image("SearchIcon")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                        .accessibilityLabel("Search")
                        Button { showingContact = true } label: {
                            Image("EmailIcon")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                        .accessibilityLabel("Contact")
                    }
                }
        }
    }
}
