import SwiftUI
struct MenuBar: View {
    enum Mode: String, CaseIterable, Identifiable {
        case weekly, monthly
        var id: Self { self }
    }

    @State private var selectedFlavor: Mode = .weekly
    
    var body: some View {
        VStack {
            Picker("Mode", selection: $selectedFlavor) {
                Text("Weekly").tag(Mode.weekly)
                Text("Monthly").tag(Mode.monthly)
            }
            .frame(width: 200.0)
        }
    }
}
