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
    var temp = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = clickedAnimal.name
        levelLabel.text = "LVL \(clickedAnimal.level)"
        
        setUpBars()
        
        
        
        
        
        let scene = SKScene(size: animalView.bounds.size)
        scene.backgroundColor = UIColor.white
        self.view.bounds = UIScreen.main.bounds
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let temp = clickedAnimal.sprite!.createSprite(size: animalView.bounds.size)
        scene.addChild(temp)
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
       
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
