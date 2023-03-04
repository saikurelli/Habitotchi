//
//  HabitViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 2/28/23.
//

import UIKit
import SwiftUI
import SpriteKit

class HabitStatsViewController: UIViewController {

    @IBOutlet weak var animalSprite: SKView!
    
    @IBOutlet weak var goalStatViewMode: UIPickerView!
    @IBOutlet weak var habitLabel: UILabel!
    var fetchedHabit = Habit(name: "", goal: "")
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var goalLabel: UILabel!
    var delegate : UIViewController!
    
    @IBOutlet weak var longestStreak: UILabel!
    @IBOutlet weak var currentStreak: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up Sprite Animal
        
        let scene = SKScene(size: animalSprite.bounds.size)
        scene.backgroundColor = UIColor.white
        self.view.bounds = UIScreen.main.bounds
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        scene.addChild(fetchedHabit.animal.sprite.createSprite(size: animalSprite.bounds.size))
        animalSprite.presentScene(scene)
        
        
        
        habitLabel.text = fetchedHabit.name
        currentStreak.text = String(fetchedHabit.daysCompleted)
        goalLabel.text = fetchedHabit.goal
        longestStreak.text = String(0)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        fetchedHabit.habitCircleChecked()
    }
    
    private func configureNavBar(){
        let navController = self.navigationController
        navController?.navigationBar.backgroundColor = .white
        navController?.navigationBar.tintColor = DARK_GREEN
        navController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:DARK_GREEN]
        }
}
