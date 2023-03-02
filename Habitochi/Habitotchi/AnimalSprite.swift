//
//  AnimalSprite.swift
//  Habitotchi
//
//  Created by Cole Harper on 2/28/23.
//

import Foundation
import SpriteKit

class AnimalSprite : SKSpriteNode{
    
    var animal : Animal!
    //need a way to tell parent viewController to segue to another scene
    init(imageName: String, name: String){
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.name = name
        self.isUserInteractionEnabled = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(self.name!) has been touched")
        self.animal.spriteTouched()
    }
    
    func setAnimal(animal : Animal){
        self.animal = animal
    }
    
}
