//
//  AnimalSprite.swift
//  Habitotchi
//
//  Created by Cole Harper on 2/28/23.
//

import Foundation
import SpriteKit

public class AnimalSprite : SKSpriteNode{
    
    var animal : Animal!
    private var framesLibrary: [String : [SKTexture]] = [:]
    private var imageName: String = "black_cat"
    private var timePerFrame = 0.2
    private var scale: Float!
    //need a way to tell parent viewController to segue to another scene
    init(animal: Animal, imageName: String, name: String, scale: Float? = 1.0){
        let initialTexture = SKTexture(imageNamed: imageName)
        
        let imageSize: CGSize = initialTexture.size()
        super.init(texture: initialTexture, color: .clear, size: imageSize)
        self.scale = scale
        determineCorrectScale(initialScale: scale!)
        self.name = name
        self.isUserInteractionEnabled = true
        self.imageName = imageName
        self.animal = animal
    }
    
    
    func changeAnimationTo(animalState: AnimalState) {
        switch animalState {
            case AnimalState.ill:
                animateDead()
            case AnimalState.unhealthy:
                animateUnhealthy()
            case AnimalState.healthy:
                animateHealthy()
            case AnimalState.aboutToLevelUp:
                animateAboutToLevelUp()
            case AnimalState.leveledUp:
                animateLeveledUp()
        }
        
    }
    private func loadFrames(animalAction: String) {
        let atlas = SKTextureAtlas(named: "\(imageName)_\(animalAction)")
        var frames: [SKTexture] = []
        let lastIndex = atlas.textureNames.count - 1
        for i in 0...lastIndex{
            let textureName = "\(i)"
            print("Importing: \(textureName)")
            frames.append(atlas.textureNamed(textureName))
        }
        framesLibrary[animalAction] = frames
    }
    
    private func animateDead() {
        if !framesLibrary.keys.contains("dying") {
            loadFrames(animalAction: "dying")
            loadFrames(animalAction: "dead")
        }
        setUpAnimation(animalAction: "dying")
        self.run(SKAction.sequence([
                    SKAction.animate(with: framesLibrary["dying"]!,
                                  timePerFrame: timePerFrame,
                                  resize: false,
                                  restore: true),
                    SKAction.repeatForever(
                        SKAction.animate(with: framesLibrary["dead"]!,
                                      timePerFrame: timePerFrame,
                                      resize: false,
                                      restore: true)
                    )
                  
                ])
        )

    }
    
    private func animateUnhealthy() {
        if !framesLibrary.keys.contains("lying"){
            loadFrames(animalAction: "lying")
        }
        setUpAnimation(animalAction: "lying")
    }
    
    private func animateHealthy() {
        if !framesLibrary.keys.contains("sitting") {
            loadFrames(animalAction: "sitting")
            loadFrames(animalAction: "acting")
        }
        
        print(framesLibrary["sitting"]!.count)
        setUpAnimation(animalAction: "sitting")
        let sitting =  SKAction.animate(with: framesLibrary["sitting"]!,
                                                timePerFrame: timePerFrame,
                                                resize: false,
                                                restore: true)
        let acting = SKAction.animate(with: framesLibrary["acting"]!,
                                                timePerFrame: timePerFrame,
                                                resize: false,
                                                restore: true)
        self.run(
            SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.repeat(sitting, count: Int.random(in: 15..<25)),
                    acting
                ])
            )
        )
    }
    
    private func animateAboutToLevelUp() {
        if framesLibrary["standing"] == nil {
            loadFrames(animalAction: "standing")
        }
        setUpAnimation(animalAction: "standing")
    
        self.run(SKAction.repeatForever(
                    SKAction.animate(with: framesLibrary["standing"]!,
                                          timePerFrame: timePerFrame,
                                          resize: false,
                                          restore: true
                    )
                )
        )
    }
    
    private func animateLeveledUp() {
        if framesLibrary["playing"] == nil {
            loadFrames(animalAction: "playing")
        }
        if !framesLibrary.keys.contains("sitting") {
            loadFrames(animalAction: "sitting")
            loadFrames(animalAction: "acting")
        }
        let sitting =  SKAction.animate(with: framesLibrary["sitting"]!,
                                                timePerFrame: timePerFrame,
                                                resize: false,
                                                restore: true)
        let acting = SKAction.animate(with: framesLibrary["acting"]!,
                                                timePerFrame: timePerFrame,
                                                resize: false,
                                                restore: true)
        setUpAnimation(animalAction: "playing")
        self.run(SKAction.sequence([
                    SKAction.animate(with: framesLibrary["playing"]!,
                                  timePerFrame: timePerFrame,
                                 resize: false,
                                 restore: true),
                    SKAction.repeatForever(
                        SKAction.sequence([
                            SKAction.repeat(sitting, count: Int.random(in: 15..<25)),
                            acting
                        ])
                    )
                ])
        )
    }
    
    // To create the size difference between a dog and a cat
    func determineCorrectScale(initialScale: Float) {
        print(imageName)
        if imageName.suffix(3) == "dog" {
            self.scale = scale * 1.5
        }
    }
    
    
    private func setUpAnimation(animalAction: String){
        let firstFrameTexture = framesLibrary[animalAction]![0]
        self.texture = firstFrameTexture
        self.size = firstFrameTexture.size()
        self.setScale(CGFloat(scale))
    }
    
    
//    func createSprite (size: CGSize, spriteName: String) -> SKSpriteNode{
//        return SKSpriteNode(texture: SKTexture(imageNamed: spriteName), color: .clear, size: size)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(self.name!) has been touched")
        self.animal.spriteTouched()
    }
    
    func setAnimal(animal : Animal){
        self.animal = animal
    }
    
}
