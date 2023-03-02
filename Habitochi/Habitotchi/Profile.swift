//
//  Profile.swift
//  Habitotchi
//
//  Created by Cole Harper on 2/28/23.
//

import Foundation
import UIKit


//MARK: A basic data structure for a profile, will contain fields for name, profile picture, and habit array?

public class Profile : NSObject {
    
    var name : String
    var profileImage : UIImage
    var habits : [Habit]
    
    init(name: String) {
        self.name = name
        self.profileImage = UIImage(systemName: "person.circle.fill")!
        self.habits = []
    }
    
    //Function to set profile picture
    func setProfilePic() {
        
    }
    
    //Func that will call initial habit creation VC?
    func setInitialHabit(){
        
    }
    
    func hardcode(){
       // currentProfile = Profile(name: "Test")
        let habit1 = Habit(name: "Exercise", goal: "I want to run 2 miles a day")
        let animal = Animal(AnimalName: "john", spriteName: "SpriteTest2")
        let habit2 = Habit(name: "Read", goal: "Read for an hour everyday")
        let animal2 = Animal(AnimalName: "jerry", spriteName: "SpriteTest")
        habit1.animal = animal
        habit2.animal = animal2
        self.habits.append(habit1)
        self.habits.append(habit2)
    }
    
}
