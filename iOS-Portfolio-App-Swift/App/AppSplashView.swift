import SwiftUI
import UIKit

struct AppSplashView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            if let logoImage = Self.logoImage {
                Image(uiImage: logoImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .accessibilityHidden(true)
            } else {
                Text("HT")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .frame(width: 120, height: 120)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Circle())
                    .accessibilityHidden(true)
            }
        }
    }

    private static var logoImage: UIImage? {
        UIImage(named: "LaunchLogo")
            ?? UIImage(named: "icon-1024")
            ?? UIImage(named: "icon-1024.png")
            ?? UIImage(named: "icon-60")
            ?? UIImage(named: "icon-60@3x.png")
    }
}

#Preview {
    AppSplashView()
}
