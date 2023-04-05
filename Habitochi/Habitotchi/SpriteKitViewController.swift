//
//  SpriteKitViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 2/28/23.
//


//MARK: If we add a new habit, need to add a new animal to the scene


import UIKit
import SpriteKit

class SpriteKitViewController: UIViewController {
    
    
    @IBOutlet weak var skView: SKView!
    @IBOutlet var profileButton: UIButton!
    var scene : BackgroundScene!
    
    
    //view will load check if there is a new habit, then add to Observer obeject?

   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        profileButton.tintColor = .black
        
        self.view = skView
        scene = BackgroundScene(size: skView.bounds.size, vc: self)
        scene.backgroundColor = UIColor.white
        self.view.bounds = UIScreen.main.bounds
        scene.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        
        skView.presentScene(scene)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if currentProfile.addedOrEditedHabit {
            scene.addedNewSprite()
            currentProfile.addedOrEditedHabit = false
        }
    }

    
    func presentAnimalStatus(animal : Animal){
        performSegue(withIdentifier: "animalStatusSegueIdentifier", sender: animal)
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animalStatusSegueIdentifier",
           let destination = segue.destination as? AnimalStatusViewController{
            if let sheet = destination.sheetPresentationController{
                sheet.detents = [.medium()]
            }
            
            destination.clickedAnimal = (sender as! Animal)
            destination.delegate = self
        }
    }
    

    class BackgroundScene: SKScene {
        
        var vc : SpriteKitViewController!
        var habits: [Habit] = currentProfile.habits!.array as! [Habit]
        
        init(size: CGSize, vc: SpriteKitViewController) {
            super.init(size: size)
            self.vc = vc
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func didMove(to view: SKView) {
            let background = SKSpriteNode(texture: SKTexture(imageNamed: "background"),  size: CGSize(width: 394, height: 346))
            background.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            background.position = CGPoint(x: 0.0, y: 0.0)
            addChild(background)
            
            let sunNode = SKSpriteNode(texture: SKTexture(imageNamed: "sun"), size: CGSize(width: 50, height: 50))
            sunNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            sunNode.position = CGPoint(x: 325.0, y: 295.0)
            addChild(sunNode)
            
            loadSprites()
        }
        
        public func loadSprites(){
            let offset = 50
            var pos = Int(vc.view.frame.midX) - 150
            //Move this to a new func
           
            for habit in habits{
                let animal = habit.animal
                animal.setAnimalSpriteDelegate()
                animal.delegate = vc
                var animalSprite = animal.sprite!.createSprite(size: CGSize(width: 50.0, height: 50.0), spriteName: animal.spriteName!)
                animalSprite.isUserInteractionEnabled = true
                animalSprite.position = CGPoint(x: pos , y: 100)
                addChild(animalSprite)
                pos += offset
            }
            
            //createProfileButton(scene : scene)
        }
        
        func addedNewSprite(){
            habits = currentProfile.habits!.array as! [Habit]
            for children in self.children{
                children.removeFromParent()
            }
            didMove(to: vc.skView)
        }
    }

    
}



    

    
