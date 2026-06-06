import SwiftUI
import UIKit

struct BundledImage: View {
    let name: String

    var body: some View {
        if let image = UIImage(named: name) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            Color.logoGreyLight
        }
    }
}
