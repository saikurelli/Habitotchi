//
//  SpriteKitViewController.swift
//  Habitochi
//
//  Created by Cole Harper on 2/28/23.
//


//MARK: If we add a new habit, need to add a new animal to the scene

//Idea for how to get to modally present Animal Status page, have a delegate in the animal sprite class that will tell parent animal class that it has been touched, from which the animal will create the modal sheet
import UIKit
import SpriteKit

class SpriteKitViewController: UIViewController {
    
    
    @IBOutlet weak var skView: SKView!
    
    
    
    
    //view will load check if there is a new habit, then add to Observer obeject?

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = skView
        let scene = SKScene(size: skView.bounds.size)
        scene.backgroundColor = UIColor.white
        self.view.bounds = UIScreen.main.bounds
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let sprite = AnimalSprite(imageName: "SpriteTest", name: "dog")
        sprite.position = CGPoint(x: 0.0, y: 0.0)
        sprite.size = CGSize(width: 100.0, height: 100.0)
        scene.addChild(sprite)
        
       
        if let skView = self.view as? SKView {
            skView.presentScene(scene)
        }

        
        
//        if sprite.delegate == true {
//
//            let destination = AnimalStatusViewController()
//            destination.temp = sprite.name!
//            let segue = UIStoryboardSegue(identifier: "AnimalStatusSegueIdentifier", source: self, destination: destination)
//            destination.modalPresentationStyle = .fullScreen
//            performSegue(withIdentifier: "AnimalStatusSegueIdentifier", sender: self)
//            show(destination, sender: self)
//        }
        
        
        // Do any additional setup after loading the view.
    }
    
}



    

    
