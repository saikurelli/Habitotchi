import SwiftUI


public let boxSize : CGFloat = 50
struct CalendarElem: View {
    var weekMode : Bool = true
    var weekColors: [Bool] = []
    var monthColors: [Bool] = []
    var header: [String] = []
    init(weekMode mode: Bool, weekChecks week: [Bool], monthChecks month: [Bool], header headerString: [String]) {
        weekMode = mode
        weekColors = week
        monthColors = month
        header = headerString
    }
    
    var body: some View {
        
        ZStack {
            
            let array = self.weekMode ? weekColors : monthColors
            let monthOffset = self.weekMode ? 0 : 5
            let sizeColors = array.count
            
            // offSet to center Success View Calendar for a week display
            let offSetY = self.weekMode ? CGFloat(40) : CGFloat(0)
        
            generateHeader(offSetY: offSetY) 
            
            ForEach(0..<sizeColors, id: \.self) {
                let colIndex = ($0 + monthOffset)/7
                // Put each box
                let rowIndex = ($0 + monthOffset)%7
                BoxImg(status: array[$0]).offset(x: CGFloat(rowIndex) * boxSize, y: CGFloat(25 * colIndex) + (offSetY + 25) )
            }
        }
    }
    func generateHeader (offSetY: CGFloat) -> some View {
        return ZStack {
            let days = header
            
            ForEach(0..<days.count, id: \.self) {
                Text (days[$0]).offset(x: CGFloat($0) * boxSize, y: offSetY)
            }
        }
    }
}
// General Wrapper that gets a View element based on status variable
func BoxImg (status : Bool) -> some View {
    if status {
        return ZStack {
            AnyView(CheckBoxImg())
        }
        
    } else {
        return ZStack {
            AnyView(EmptyBox())
        }
    }
}
