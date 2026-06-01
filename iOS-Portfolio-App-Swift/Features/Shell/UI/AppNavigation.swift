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
                    }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button { showingSearch = true } label: {
                            Image(systemName: "magnifyingglass")
                        }
                        Button { showingContact = true } label: {
                            Image(systemName: "envelope")
                        }
                    }
                }
        }
    }
}
