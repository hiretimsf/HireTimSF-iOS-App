import SwiftUI
import UIKit

struct BundledImage: View {
    let name: String

    var body: some View {
        if let image = UIImage(named: name) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else if let path = Bundle.main.path(forResource: name, ofType: "png"),
                  let image = UIImage(contentsOfFile: path) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            Color.logoGreyLight
        }
    }
}
