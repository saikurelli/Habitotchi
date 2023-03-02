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
    
    
    
    
    //view will load check if there is a new habit, then add to Observer obeject?

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileButton.tintColor = .black
        
        self.view = skView
        let scene = SKScene(size: skView.bounds.size)
        scene.backgroundColor = UIColor.white
        self.view.bounds = UIScreen.main.bounds
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        loadSprites(profile: currentProfile, scene: scene)
        scene.backgroundColor = DARK_GREEN
        skView.presentScene(scene)
        
    
        
        
        // Do any additional setup after loading the view.
    }
    
    
    //loads the sprites that are in the profile habit's arrays
    func loadSprites(profile : Profile, scene : SKScene){
        let offset = 100
        var pos = 0
        
        //Move this to a new func
        for habit in profile.habits{
            let animal = habit.animal
            animal.setAnimalSpriteDelegate()
            animal.delegate = self
            let animalSprite = animal.sprite
            animalSprite.position = CGPoint(x: -pos , y: -50)
            animalSprite.size = CGSize(width: 50.0, height: 50.0)
            scene.addChild(animalSprite)
            pos += offset
        }
        
        //createProfileButton(scene : scene)
    }
    
    func presentAnimalStatus(animal : Animal){
        performSegue(withIdentifier: "animalStatusSegueIdentifier", sender: animal)
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animalStatusSegueIdentifier",
           let destination = segue.destination as? AnimalStatusViewController{
            if let sheet = destination.sheetPresentationController{
                sheet.detents = [.medium(),.large()]
            }
            
            destination.clickedAnimal = (sender as! Animal)
            destination.delegate = self
        }
    }
    
}



    

    
