//
//  AnimalSprite.swift
//  Habitotchi
//
//  Created by Cole Harper on 2/28/23.
//

import Foundation
import SpriteKit

public class AnimalSprite : SKSpriteNode{
    
    var animal : Animal!
    var animalTexture: SKTexture!
    //need a way to tell parent viewController to segue to another scene
    init(imageName: String, name: String){
        animalTexture = SKTexture(imageNamed: imageName)
        
        super.init(texture: animalTexture, color: .clear, size: animalTexture.size())
        self.name = name
        self.isUserInteractionEnabled = true
    }
    
    
    func createSprite (size: CGSize) -> SKSpriteNode{
        return SKSpriteNode(texture: animalTexture, color: .clear, size: size)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(self.name!) has been touched")
        self.animal.spriteTouched()
    }
    
    func setAnimal(animal : Animal){
        self.animal = animal
    }
    
}
