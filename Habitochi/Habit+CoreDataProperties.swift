//
//  Habit+CoreDataProperties.swift
//  Habitotchi
//
//  Created by Peter on 4/1/23.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var daysCompleted: Int64
    @NSManaged public var desc: String?
    @NSManaged public var habitCompleted: Bool
    @NSManaged public var habitCreationDate: Date
    @NSManaged public var name: String
    @NSManaged public var reminderDays: [String]
    @NSManaged public var reminderTime: Date?
    @NSManaged public var streak: Int64
    @NSManaged public var animal: Animal
    @NSManaged public var profile: Profile
    
    convenience init(profile: Profile,
                     name: String,
                        desc: String,
                        reminderDays : [String],
                        reminderTime: Date,
                        animal: Animal,
                        context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "Habit", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.profile = profile
        self.name = name
        self.desc = desc
        self.reminderDays = reminderDays
        self.reminderTime = reminderTime
        self.animal = animal
        self.daysCompleted = 0
        self.streak = 0
        self.habitCreationDate = Date()
    }
    
    func habitCircleChecked(){
        print("\(name) has been completed")
        daysCompleted += 1
        streak += 1
        habitCompleted = true
//        animal.habitCompleted() // CoreDataManager now performs this line
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
}

extension Habit : Identifiable {

}


