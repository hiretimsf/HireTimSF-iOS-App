import SwiftUI
import UIKit

struct NavigationDrawer: View {
    @Binding var selectedTab: AppTab
    @Binding var showingDrawer: Bool
    @Binding var showingContact: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                Color.chromeBackground
                HeaderPattern()
                    .opacity(0.14)
                HStack(spacing: 14) {
                    BundledImage(name: "profile")
                        .frame(width: 62, height: 62)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.onChrome.opacity(0.9), lineWidth: 1))
                    VStack(alignment: .leading, spacing: 4) {
                        Text(PortfolioData.profile.name)
                            .font(.headline.weight(.bold))
                        Text(PortfolioData.profile.title)
                            .font(.subheadline)
                            .opacity(0.78)
                    }
                    .foregroundStyle(Color.onChrome)
                }
                .padding(20)
            }
            .frame(height: 176)

            ForEach(AppTab.allCases) { tab in
                DrawerRow(title: tab.title, systemImage: tab.systemImage, imageAsset: tab.imageAsset, selected: selectedTab == tab) {
                    selectedTab = tab
                    showingDrawer = false
                }
            }

            Divider()
                .padding(.vertical, 8)

            DrawerRow(title: "Contact", systemImage: "envelope", imageAsset: "EmailIcon", selected: false) {
                showingDrawer = false
                showingContact = true
            }

            Spacer()
        }
        .frame(width: min(320, UIScreen.main.bounds.width * 0.82))
        .background(Color.cardBackground)
        .ignoresSafeArea()
        .shadow(color: .black.opacity(0.22), radius: 18, x: 4)
    }
}
