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
        
        
        // set up labels
        habitLabel.text = fetchedHabit.name
        currentStreak.text = String(fetchedHabit.daysCompleted)
        goalLabel.text = fetchedHabit.goal
        longestStreak.text = String(0)
        
        setUpPicker()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpPicker(){
        goalStatViewMode.dataSource
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }
    
    private func configureNavBar(){
        let navController = self.navigationController
        navController?.navigationBar.backgroundColor = .white
        navController?.navigationBar.tintColor = DARK_GREEN
        navController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:DARK_GREEN]
        // edit button at nav top right
        let nav = self.navigationItem
        let editStatScreen = UIBarButtonItem(title: "profileButton", style: UIBarButtonItem.Style.done, target: self, action: nil)
        editStatScreen.image = UIImage(systemName: "pencil.and.outline")
        editStatScreen.tintColor = DARK_GREEN
        nav.rightBarButtonItem = editStatScreen
        }
}
