//
//  Habit.swift
//  Habitotchi
//
//  Created by Cole Harper on 2/28/23.
//

import Foundation
import UserNotifications

//MARK: basic data structure for a habit, profile will probably have an array of habits.

//MARK: Each habit will have a habit name, goal, associated animal, and schedule for how to send reminders

class Habit : NSObject{
    
    var name : String
    var desc : String
    var reminderDays : [String]
    var reminderTime: String
    var animal : Animal
    var daysCompleted : Int
    var streak : Int
    var habitCreationDate : Date
    var habitCompleted = false
    
    init(name: String,
         desc: String,
         reminderDays : [String],
         reminderTime: String,
         animal: Animal) {
        self.name = name
        self.desc = desc
        self.reminderDays = reminderDays
        self.reminderTime = reminderTime
        self.animal = animal
        self.daysCompleted = 0
        self.streak = 0
<<<<<<< Updated upstream
        self.HabitCreationDate = Date()
        
=======
        self.habitCreationDate = Date()
>>>>>>> Stashed changes
    }
    
    func habitCircleChecked(){
        print("\(name) has been completed")
        daysCompleted += 1
        streak += 1
        habitCompleted = true
        animal.habitCompleted()
    }
    
    func habitCircleUnchecked(){
        daysCompleted -= 1
        streak -= 1
        //need to decrement animal data
    }
    
    func dailyHabitCheck(){
        
        if !habitCompleted{
            streak = 0
            animal.failedToCompleteHabit()
        }
        
        habitCompleted = false
        
        
    }

    func updateHabit(name: String, desc: String, reminderDays : [String], reminderTime: String, animal: Animal){
        self.name = name
        self.desc = desc
        self.reminderDays = reminderDays
        self.reminderTime = reminderTime
        self.animal = animal
        // force reload all views
        currentProfile.addedOrEditedHabit = true
    }
    
    
    
    
    
    
    
    
    
}
