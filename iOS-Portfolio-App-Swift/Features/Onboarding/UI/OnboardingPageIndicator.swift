import SwiftUI

struct OnboardingPageIndicator: View {
    let count: Int
    let selectedIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count, id: \.self) { index in
                Capsule()
                    .fill(index == selectedIndex ? Color.brandPrimary : Color.logoGrey.opacity(0.35))
                    .frame(width: index == selectedIndex ? 24 : 8, height: 8)
                    .animation(.easeInOut(duration: 0.2), value: selectedIndex)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Onboarding page \(selectedIndex + 1) of \(count)")
    }
}
