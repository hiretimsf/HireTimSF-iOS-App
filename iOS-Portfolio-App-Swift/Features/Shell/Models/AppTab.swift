enum AppTab: String, CaseIterable, Identifiable, Sendable {
    case profile
    case portfolio
    case blog
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .profile: "Profile"
        case .portfolio: "Portfolio"
        case .blog: "Blog"
        case .settings: "Settings"
        }
    }

    var systemImage: String {
        switch self {
        case .profile: "person.crop.circle"
        case .portfolio: "rectangle.stack"
        case .blog: "text.alignleft"
        case .settings: "gearshape"
        }
    }
}
