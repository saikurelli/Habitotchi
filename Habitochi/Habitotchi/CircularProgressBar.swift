// Project: Habitotchi
//  
//  EID: sk49777
//  Course: CS371L

import SwiftUI
import CircularProgress

struct CircularProgressBar: View {
    let count : Int
    let total : Int
    init(count: Int, creationDate: Date) {
        self.count = count
        // get number of days between total and today
        let calendarComponents = Calendar.current.dateComponents([.day], from: creationDate, to: Date())
        self.total = calendarComponents.day! + 1
    }
    var progress: CGFloat {
        return CGFloat(count)/CGFloat(total)
    }
    var body: some View {
        VStack {
            // Render circular progress view with
            CircularProgressView(count: count, total: total, progress: progress, fill: LinearGradient(gradient: Gradient(colors: [Color(DARK_GREEN), Color(GREEN)]), startPoint: .leading, endPoint: .trailing), showText: false)
                .frame(width: 300, height: 300)
            
            let topText = "\(round(progress * 1000) / 10.0)%"
            let bottomText = "\(count)/\(total) days"
            
            Text(topText).font(.system(size: 75)).foregroundColor(Color(DARK_GREEN)).bold().position(x: 155, y: -175)
            Text(bottomText).font(Font.caption).bold().position(x: 150, y: -175)
            
        }
    }
}
