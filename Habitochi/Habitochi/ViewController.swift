// Project: Habitochi
//  
//  EID: sk49777
//  Course: CS371L


import UIKit


public var tempProfile = Profile(name: "Test")

public let DARK_GREEN = UIColor(r: 74, g: 116, b: 21, a: 72)
public let GREEN = UIColor(r: 167, g: 193, b: 129, a: 60)

//quick extension that can be useful for creating custom UIColors
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a/100)
    }
}


var habit1 = Habit(name: "Exercise", goal: "I want to run 2 miles a day")

var animal = Animal(AnimalName: "john", spriteName: "SpriteTest")

var habit2 = Habit(name: "Read", goal: "Read for an hour everyday")

var animal2 = Animal(AnimalName: "jerry", spriteName: "SpriteTest")








class ViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

