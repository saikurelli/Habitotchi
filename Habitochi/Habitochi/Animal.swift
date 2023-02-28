//
//  Animal.swift
//  Habitochi
//
//  Created by Cole Harper on 2/28/23.
//

import Foundation

//MARK: basic data structure for an animal, each habit will only have one habit

//MARK: Each habit will have a habit name, goal, associated animal, and schedule for how to send reminders
class Animal {
    
    var name : String
    var level : Int
    var health : Int
    var maxHealth = 10
    var xpts : Int
    var xptsNeeded = 100
    var sprite : AnimalSprite
    
    init() {
        name = ""
        level = 1
        health = maxHealth
        xpts = 0
        sprite = AnimalSprite(imageName: "spriteTest", name: "dummy")
    }
    
    init(AnimalName name : String, spriteName spriteString : String) {
        self.name = name
        level = 1
        health = maxHealth
        xpts = 0
        sprite = AnimalSprite(imageName: spriteString, name: name)
    }
    
    func habitCompleted(){
        if health != maxHealth{
            health += 1
        }else{
            xpts += 1
            checkLevelUp()
        }
    }
    
    func checkLevelUp() {
        if xpts == xptsNeeded {
            levelUp()
        }
    }
    
    //MARK: need to add further functionality
    func levelUp(){
        level += 1
    }
    
}
