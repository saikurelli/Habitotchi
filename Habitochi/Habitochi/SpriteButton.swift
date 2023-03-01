//
//  SpriteButton.swift
//  Habitochi
//
//  Created by Cole Harper on 3/1/23.
//

import Foundation
import SpriteKit

class SpriteButton : SKSpriteNode {
   
    var buttonRole : String!
    
    init(image: UIImage, role : String){
        let texture = SKTexture(image: image)
        super.init(texture: texture, color: GREEN, size: texture.size())
        buttonRole = role
        self.isUserInteractionEnabled = true
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch buttonRole {
        case "profile":
            print("success")
        default:
            print("ERROR WITH SPRITEKIT BUTTONS")
        }
    }
    
}
