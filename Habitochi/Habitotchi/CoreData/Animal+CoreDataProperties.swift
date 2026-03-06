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
         fed = "fed"
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
    @NSManaged public var food: Int64

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
        food = 0
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
        if xpts >= xptsNeeded {
            levelUp()
        }
    }

    //MARK: need to add further functionality
    private func levelUp(){
        level += 1
        xpts = xpts - xptsNeeded
        xptsNeeded = Int64(Double(xptsNeeded) * 1.15)
        food += 3
    }
    
    func failedToCompleteHabit(daysLost: Int){
        health -= Int64(daysLost)
        health = max(0, health) // prevent negative health
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
        self.delegate?.presentAnimalStatus(animal: self)
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
