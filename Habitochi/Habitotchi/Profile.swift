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
    var customProfilePic = false
    
    init(name: String) {
        self.name = name
        self.profileImage = UIImage(systemName: "person.circle.fill")!
        self.habits = []
    }
    
    //Function to set profile picture
    func setProfilePic(image: UIImage) {
        customProfilePic = true
        profileImage = image
    }
    

    func addHabit(newHabit: Habit) {
        habits.append(newHabit)
    }
    
    // #DEBUG# purposes
    func printHabits() {
        print("#DEBUG#\n")
        for habit in habits {
            print("Habit name: " + habit.name + " | Pet assigned: " + habit.animal.name)
            print("\n")
        }
    }

    func setName(name: String) {
        self.name = name
    }
    
    
    func hardcode(){
       // currentProfile = Profile(name: "Test")
        let animal = Animal(AnimalName: "john", spriteName: "SpriteTest2")
        let habit1 = Habit(name: "Exercise", desc: "I want to run 2 miles a day", reminderDays: [], reminderTime: DateFormatter(), animal: animal)
        
        let animal2 = Animal(AnimalName: "jerry", spriteName: "SpriteTest")
        let habit2 =  Habit(name: "Read", desc: "Read for an hour every day", reminderDays: [], reminderTime: DateFormatter(), animal: animal2)

        profileImage = UIImage(named: "testProfilePic")!
        habit1.animal = animal
        habit2.animal = animal2
        self.habits.append(habit1)
        self.habits.append(habit2)
    }
    
    
}
