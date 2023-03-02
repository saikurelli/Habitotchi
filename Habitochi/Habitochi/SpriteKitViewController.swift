//
//  SpriteKitViewController.swift
//  Habitochi
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
        habit1.animal = animal
        tempProfile.habits.append(habit1)
        habit2.animal = animal2
        tempProfile.habits.append(habit2)
        
        profileButton.tintColor = .black
        
        self.view = skView
        let scene = SKScene(size: skView.bounds.size)
        scene.backgroundColor = UIColor.white
        self.view.bounds = UIScreen.main.bounds
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        
        loadSprites(profile: tempProfile, scene: scene)
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
            animalSprite.position = CGPoint(x: pos , y: pos)
            animalSprite.size = CGSize(width: 50.0, height: 50.0)
            scene.addChild(animalSprite)
            pos += offset
        }
        
        createProfileButton(scene : scene)
    }
    
    func presentAnimalStatus(animal : Animal){
        performSegue(withIdentifier: "animalStatusSegueIdentifier", sender: animal)
        
    }
    
    func createProfileButton(scene : SKScene){
        
        //MARK: Need to change this to be whatever the profile picture is
        let image = UIImage(systemName: "person.crop.circle")
        let button = SpriteButton(image: image!, role: "profile")
        button.color = DARK_GREEN
        button.position = CGPoint(x: 50.0, y: 50.0)
        button.size = CGSize(width: 20.0, height: 20.0)
        scene.addChild(button)
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



    

    
