import SwiftUI

extension Color {
    static let brandPrimary = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.431, green: 0.659, blue: 0.996, alpha: 1)
            : UIColor(red: 0.000, green: 0.380, blue: 0.749, alpha: 1)
    })

    static let chromeBackground = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.122, green: 0.122, blue: 0.122, alpha: 1)
            : UIColor(red: 0.000, green: 0.380, blue: 0.749, alpha: 1)
    })

    static let onChrome = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.886, green: 0.886, blue: 0.886, alpha: 1)
            : UIColor.white
    })

    static let appBackground = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
            : UIColor.white
    })

    static let cardBackground = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.106, green: 0.106, blue: 0.106, alpha: 1)
            : UIColor.white
    })

    static let headerBackground = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.125, green: 0.129, blue: 0.141, alpha: 1)
            : UIColor(red: 0.886, green: 0.886, blue: 0.886, alpha: 1)
    })

    static let headerTitle = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.816, green: 0.831, blue: 0.855, alpha: 1)
            : UIColor(red: 0.373, green: 0.388, blue: 0.408, alpha: 1)
    })

    static let selectedItemBackground = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.227, green: 0.141, blue: 0.086, alpha: 1)
            : UIColor(red: 0.910, green: 0.945, blue: 1.000, alpha: 1)
    })

    static let selectedItemContent = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.961, green: 0.620, blue: 0.043, alpha: 1)
            : UIColor(red: 0.000, green: 0.380, blue: 0.749, alpha: 1)
    })

    static let primaryText = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
            : UIColor(red: 0.102, green: 0.125, blue: 0.145, alpha: 1)
    })

    static let secondaryText = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.643, green: 0.643, blue: 0.643, alpha: 1)
            : UIColor(red: 0.416, green: 0.427, blue: 0.443, alpha: 1)
    })

    static let logoGrey = Color(red: 0.839, green: 0.839, blue: 0.839)

    static let logoGreyLight = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.251, green: 0.251, blue: 0.251, alpha: 1)
            : UIColor(red: 0.914, green: 0.914, blue: 0.914, alpha: 1)
    })
}
