//
//  Animal+CoreDataProperties.swift
//  Habitotchi
//
//  Created by Peter on 3/27/23.
//
//

import Foundation
import CoreData

public enum AnimalState: String {
    case ill = "ill",
         unhealthy = "unhealthy",
         healthy = "healthy",
         aboutToLevelUp = "healthy, almost ready to level up!",
         leveledUp = "leveled up"
}

extension Animal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Animal> {
        return NSFetchRequest<Animal>(entityName: "Animal")
    }

    @NSManaged public var name: String?
    @NSManaged public var level: Int64
    @NSManaged public var maxHealth: Int64
    @NSManaged public var health: Int64
    @NSManaged public var xpts: Int64
    @NSManaged public var xptsNeeded: Int64
    @NSManaged public var sprite: AnimalSprite?
    @NSManaged public var habit: Habit?
    @NSManaged public var spriteName : String

    convenience init(name : String,
                     spriteName : String,
                     context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "Animal", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.name = name
        level = 1
        maxHealth = 10
        health = maxHealth
        xpts = 0
        xptsNeeded = 100
        sprite = AnimalSprite(animal: self, imageName: spriteName, name: name)
        xptsNeeded = 10

        self.spriteName = spriteName
    }

    func habitCompleted(){
        if health != maxHealth{
            health += 1
        }else{
            xpts += 1 + Int64((habit?.streak)! / 3)
            checkLevelUp()
        }
    }

    private func checkLevelUp() {
        if xpts == xptsNeeded {
            levelUp()
        }
    }

    //MARK: need to add further functionality
    private func levelUp(){
        level += 1
        xptsNeeded = Int64(Double(xptsNeeded) * 1.15)
    }
    
    func failedToCompleteHabit(){
        // get last date from completed habit
        if habit!.habitCompletedDays.count > 0 {
            let lastDate = habit!.habitCompletedDays.last!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            
            let daysMissed = Calendar.current.dateComponents([.day], from: dateFormatter.date(from: lastDate)!, to: Date()).day!
            if daysMissed > 1 {
                health -= Int64(daysMissed)
            }
        }
        
        //Need to check if the animal is dead
        
    }

    func setAnimalSpriteDelegate(){
        if self.sprite!.animal == nil {
            self.sprite!.setAnimal(animal: self)
        }
    }

    //should only be called when the associated sprite is touched
    func spriteTouched(){
        print("\(String(describing: self.name)) - can see that the animal sprite has been touched in animal class")
        self.delegate.presentAnimalStatus(animal: self)
    }
    
    func getAnimalState() -> AnimalState{
        let firstThreshold = maxHealth / 4
        let secondThreshold = maxHealth / 4 * 3
        
        if health == 0 {
            return AnimalState.ill
        }
        else if health < firstThreshold {
            return AnimalState.unhealthy
        }
        else if (xpts == xptsNeeded - 2 && health > secondThreshold) {
            return AnimalState.aboutToLevelUp
        }
        return AnimalState.healthy
    }
}

extension Animal : Identifiable {

}
