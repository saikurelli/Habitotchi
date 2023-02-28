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
    
    
    //Cole - Need to create a PropertyManager that observes to see if a sprite has been selected, then will perform the segue
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = skView
        let scene = SKScene(size: skView.bounds.size)

        scene.backgroundColor = UIColor.white

        self.view.bounds = UIScreen.main.bounds
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let sprite = AnimalSprite(imageName: "spriteTest.png", name: "dog")
        sprite.position = CGPoint(x: 100.0, y: 100.0)
        sprite.size = CGSize(width: 100.0, height: 100.0)
        scene.addChild(sprite)
        
        
       
        if let skView = self.view as? SKView {
            skView.presentScene(scene)
        }
        
        
        if sprite.delegate == true {
            
            let destination = AnimalStatusViewController()
            destination.temp = sprite.name!
            let segue = UIStoryboardSegue(identifier: "AnimalStatusSegueIdentifier", source: self, destination: destination)
            destination.modalPresentationStyle = .fullScreen
            performSegue(withIdentifier: "AnimalStatusSegueIdentifier", sender: self)
            show(destination, sender: self)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
   
    
    
    
    }



    
    
    /*
     
     //MARK: This is how to load a .sks file into a SKView
     
     sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 666, height: 500))
     sceneView.backgroundColor = UIColor.black
     self.view.addSubview(sceneView)

     if let view = self.sceneView as SKView? {
         // Load the SKScene from 'GameScene.sks'
         if let scene = SKScene(fileNamed: "GameScene") {
             // Set the scale mode to scale to fit the window
             scene.scaleMode = .aspectFill

             // Present the scene
             view.presentScene(scene)
         }
     */
    
