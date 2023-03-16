import SwiftUI


public let boxSize : CGFloat = 50
struct CalendarElem: View {
    var weekMode : Bool = true
    
    init(weekMode mode: Bool) {
        weekMode = mode
    }
    
    var body: some View {
        let weekColors : [Bool] = [true, false, true, false, false, true]
        let monthColors : [Bool] = [false, false, false, true, false, true, true, false, false, true, false, true, false, true, false, true, true, true, true, false, true, false,true, false, true, false, true, true]
        
        ZStack {
            
            let array = self.weekMode ? weekColors : monthColors
            
            let sizeColors = array.count
            
            // offSet to center Success View Calendar for a week display
            let offSetY = self.weekMode ? CGFloat(40) : CGFloat(0)
        
            generateHeader(offSetY: offSetY)
            
            
            ForEach(0..<sizeColors, id: \.self) {
                let colIndex = $0/7
                // Put each box
                let rowIndex = $0%7
                BoxImg(status: array[$0]).offset(x: CGFloat(rowIndex) * boxSize, y: CGFloat(25 * colIndex) + (offSetY + 25) )
            }
        }
    }
}


func generateHeader (offSetY: CGFloat) -> some View {
    return ZStack {
        let days = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
        
        ForEach(0..<days.count, id: \.self) {
            Text (days[$0]).offset(x: CGFloat($0) * boxSize, y: offSetY)
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


struct EmptyBox : View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .frame(width: boxSize, height: (boxSize - 10))
        }
    }
}

struct CheckBoxImg : View {
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(named: "checkBox")!)
                .frame(width: boxSize, height: boxSize)
                
        }
    }
}
