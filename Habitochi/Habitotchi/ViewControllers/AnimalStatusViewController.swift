//
//  AnimalStatusViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 2/28/23.
//

import UIKit
import SpriteKit

class AnimalStatusViewController: UIViewController {

    var clickedAnimal : Animal!
    var delegate : SpriteKitViewController!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var animalView: SKView!
    @IBOutlet weak var hpBar: UIProgressView!
    @IBOutlet weak var xpBar: UIProgressView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var xpLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    //    var temp = ""
//    let healthStatus = ["healthy", "sick"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = clickedAnimal.name
        levelLabel.text = "LVL \(clickedAnimal.level)"
        foodLabel.text = "Food Remaining: \(clickedAnimal.food)"
        setUpBars()
    
        let scene = SKScene(size: animalView.bounds.size)
        scene.backgroundColor = UIColor.white
        self.view.bounds = UIScreen.main.bounds
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        var spriteNode = AnimalSprite(animal: clickedAnimal,
                                      imageName: clickedAnimal.spriteName,
                                      name: clickedAnimal.name!,
                                      scale: 4.0)

        spriteNode.changeAnimationTo(animalState: clickedAnimal.getAnimalState())
        scene.addChild(spriteNode)
        animalView.presentScene(scene)
        
        
    }
    
    // helper method to set up the HP and XP Bars correctly
    func setUpBars(){
        let currentHP = Float(clickedAnimal.health)/Float(clickedAnimal.maxHealth)
        hpBar.progress = currentHP
        let currentXP = Float(clickedAnimal.xpts)/Float(clickedAnimal.xptsNeeded)
        xpBar.progress = currentXP
        hpLabel.text = "\(clickedAnimal.health)/\(clickedAnimal.maxHealth)"
        xpLabel.text = "\(clickedAnimal.xpts)/\(clickedAnimal.xptsNeeded)"
        let GOLD = UIColor(r: 255, g: 215, b: 0, a: 255)
        hpBar.tintColor = GOLD
        
        statusLabel.text = "Status: \(clickedAnimal.getAnimalState())"
//        if(clickedAnimal.health <= (clickedAnimal.maxHealth / 2)){
//            statusLabel.text = "Status \(healthStatus[1])"
//        }else{
//            statusLabel.text = "Status \(healthStatus[0])"
//        }
    }
    @IBAction func feedButtonClicked(_ sender: Any) {
        if(clickedAnimal.health < clickedAnimal.maxHealth && clickedAnimal.food > 0){
            clickedAnimal.health += 1
            let currentHP = Float(clickedAnimal.health)/Float(clickedAnimal.maxHealth)
            hpBar.progress = currentHP
            hpLabel.text = "\(clickedAnimal.health)/\(clickedAnimal.maxHealth)"
            clickedAnimal.food -= 1
            foodLabel.text = "Food Remaining: \(clickedAnimal.food)"
        }
    }
    
}
