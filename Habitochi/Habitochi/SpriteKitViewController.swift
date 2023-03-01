//
//  SpriteKitViewController.swift
//  Habitochi
//
//  Created by Cole Harper on 2/28/23.
//


//MARK: If we add a new habit, need to add a new animal to the scene

//Idea 1: for how to get to modally present Animal Status page, have a delegate in the animal sprite class that will tell parent animal class that it has been touched, from which the animal will create the modal sheet

//Idea 2: When we are going to tap on an animal sprite, we can pass a delegate (the SpriteKitViewController) so that when the animalSprite is touched, the animal will request a modal street

import UIKit
import SpriteKit

class SpriteKitViewController: UIViewController {
    
    
    @IBOutlet weak var skView: SKView!
    
    
    
    
    //view will load check if there is a new habit, then add to Observer obeject?

   
    override func viewDidLoad() {
        super.viewDidLoad()
        habit1.animal = animal
        tempProfile.habits.append(habit1)
        habit2.animal = animal2
        tempProfile.habits.append(habit2)
        
        self.view = skView
        let scene = SKScene(size: skView.bounds.size)
        scene.backgroundColor = UIColor.white
        self.view.bounds = UIScreen.main.bounds
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        
        loadSprites(profile: tempProfile, scene: scene)
        
       
        if let skView = self.view as? SKView {
            skView.presentScene(scene)
        }

    
        
        
        // Do any additional setup after loading the view.
    }
    
    //loads the sprites that are in the profile habit's arrays
    func loadSprites(profile : Profile, scene : SKScene){
        let offset = 100
        var pos = 0
        for habit in profile.habits{
            let animal = habit.animal
            animal.setAnimalSpriteDelegate()
            animal.delegate = self
            let animalSprite = animal.sprite
            animalSprite.position = CGPoint(x: pos , y: pos)
            animalSprite.size = CGSize(width: 50.0, height: 50.0)
            scene.addChild(animalSprite)
            pos += offset
        }
    }
    
    func presentAnimalStatus(animal : Animal){
        performSegue(withIdentifier: "animalStatusSegueIdentifier", sender: animal)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animalStatusSegueIdentifier",
           let destination = segue.destination as? AnimalStatusViewController{
            destination.clickedAnimal = (sender as! Animal)
            destination.delegate = self
        }
    }
    
}



    

    
