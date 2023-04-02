//
//  Profile+CoreDataProperties.swift
//  Habitotchi
//
//  Created by Peter on 3/29/23.
//
//

import Foundation
import CoreData
import UIKit

extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var addedHabit: Bool
    @NSManaged public var customProfilePic: Bool
    @NSManaged public var name: String?
    @NSManaged public var profileImage: Data?
    @NSManaged public var habits: NSOrderedSet?
    
    convenience init(name: String,
                     image: UIImage,
                     context: NSManagedObjectContext) {
  
        let entity = NSEntityDescription.entity(forEntityName: "Profile", in: context)!
        self.init(entity: entity, insertInto: context)
        
//        NSEntityDescription.insertNewObject(forEntityName: "Profile", into: context)
        self.name = name
        self.profileImage = UIImage(systemName: "person.circle.fill")!.jpegData(compressionQuality: 0.0)
    }
    
    func checkDates(lastOpened: Date){
        if !Calendar.current.isDate(lastOpened, inSameDayAs: Date()) {
            resetHabits()
        }
    }
    
    func resetHabits(){
        //Go through each habit and reset them
        for case let habit as Habit in habits!.array {
            habit.dailyHabitCheck()
        }
    }

    //Function to set profile picture
//    func setProfilePic(image: UIImage) {
//        customProfilePic = true
//        profileImage = image.jpegData(compressionQuality: 0.0)
//    }


//    // #DEBUG# purposes
//    func printHabits() {
//        print("#DEBUG#\n")
//        for habit in habits {
//            print("Habit name: " + habit.name + " | Pet assigned: " + habit.animal.name)
//            print("\n")
//        }
//    }

//    func setName(name: String) {
//        self.name = name
//    }

//
//    func hardcode(){
//        // currentProfile = Profile(name: "Test")
//        let animal = Animal(AnimalName: "john", spriteName: "SpriteTest2")
//        let habit1 = Habit(name: "Exercise", desc: "I want to run 2 miles a day", reminderDays: [], reminderTime: DateFormatter(), animal: animal)
//
//        let animal2 = Animal(AnimalName: "jerry", spriteName: "SpriteTest")
//        let habit2 =  Habit(name: "Read", desc: "Read for an hour every day", reminderDays: [], reminderTime: DateFormatter(), animal: animal2)
//
//        profileImage = UIImage(named: "testProfilePic")!
//        habit1.animal = animal
//        habit2.animal = animal2
//        self.habits.append(habit1)
//        self.habits.append(habit2)
//    }
    

}

// MARK: Generated accessors for habits
extension Profile {

    @objc(insertObject:inHabitsAtIndex:)
    @NSManaged public func insertIntoHabits(_ value: Habit, at idx: Int)

    @objc(removeObjectFromHabitsAtIndex:)
    @NSManaged public func removeFromHabits(at idx: Int)

    @objc(insertHabits:atIndexes:)
    @NSManaged public func insertIntoHabits(_ values: [Habit], at indexes: NSIndexSet)

    @objc(removeHabitsAtIndexes:)
    @NSManaged public func removeFromHabits(at indexes: NSIndexSet)

    @objc(replaceObjectInHabitsAtIndex:withObject:)
    @NSManaged public func replaceHabits(at idx: Int, with value: Habit)

    @objc(replaceHabitsAtIndexes:withHabits:)
    @NSManaged public func replaceHabits(at indexes: NSIndexSet, with values: [Habit])

    @objc(addHabitsObject:)
    @NSManaged public func addToHabits(_ value: Habit)

    @objc(removeHabitsObject:)
    @NSManaged public func removeFromHabits(_ value: Habit)

    @objc(addHabits:)
    @NSManaged public func addToHabits(_ values: NSOrderedSet)

    @objc(removeHabits:)
    @NSManaged public func removeFromHabits(_ values: NSOrderedSet)

}

extension Profile : Identifiable {

}
