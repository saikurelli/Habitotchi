//
//  Animal+CoreDataProperties.swift
//  Habitotchi
//
//  Created by Peter on 3/27/23.
//
//

import Foundation
import CoreData


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
        sprite = AnimalSprite(imageName: spriteName, name: name)
    }

    func habitCompleted(){
        if health != maxHealth{
            health += 1
        }else{
            xpts += 1
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
    }
    
    func failedToCompleteHabit(){
        health -= 1
    }

    func setAnimalSpriteDelegate(){
        if self.sprite!.animal == nil {
            self.sprite!.setAnimal(animal: self)
        }
    }

    //should only be called when the associated sprite is touched
    func spriteTouched(){
        print("\(self.name) - can see that the animal sprite has been touched in animal class")
        self.delegate.presentAnimalStatus(animal: self)
    }
}

extension Animal : Identifiable {

}
