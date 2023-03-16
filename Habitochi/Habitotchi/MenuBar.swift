import SwiftUI
struct MenuBar: View {
    var delegate : HabitStatsViewController
    enum Mode: String, CaseIterable, Identifiable {
        case weekly, monthly
        var id: Self { self }
    }
    
    init(delegate : HabitStatsViewController){
        self.delegate = delegate
        self.delegate.renderSwiftCalendar(weekMode: true)
    }

    @State private var selectedFlavor: Mode = .weekly
    
    var body: some View {
        VStack {
            Picker("Mode", selection: $selectedFlavor) {
                Text("Weekly").tag(Mode.weekly)
                Text("Monthly").tag(Mode.monthly)
            }
            .frame(width: 200.0)
            .onChange(of: selectedFlavor, perform: {
                value in
                self.delegate.clearCalendarBox()
                self.delegate.renderSwiftCalendar(weekMode: value == Mode.weekly)
                print(value)
                // call to re-render calendar view
            })
        }
    }
}
