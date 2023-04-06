// Project: Habitotchi
//
//  EID: sk49777
//  Course: CS371L


import SwiftUI

struct EmptyBox : View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .frame(width: boxSize, height: (boxSize - 10))
        }
    }
}
