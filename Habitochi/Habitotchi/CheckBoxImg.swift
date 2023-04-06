// Project: Habitotchi
//
//  EID: sk49777
//  Course: CS371L


import SwiftUI

struct CheckBoxImg : View {
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(named: "checkBox")!)
                .frame(width: boxSize, height: boxSize)
        }
    }
}
