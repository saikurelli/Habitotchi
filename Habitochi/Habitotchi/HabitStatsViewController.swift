//
//  HabitViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 2/28/23.
//

import UIKit
import SwiftUI
import SpriteKit

class HabitStatsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var animalSprite: SKView!
    
    @IBOutlet weak var descStatViewMode: UIPickerView!
    var pickerData: [String] = [String]()
    
    @IBOutlet weak var habitLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    var fetchedHabit = Habit(name: "", desc: "", reminderDays: [], reminderTime: DateFormatter(), animal: Animal())
    
    @IBOutlet weak var progressView: UIProgressView!
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
        descLabel.text = fetchedHabit.desc
        longestStreak.text = String(0)
        progressView.progress = Float(currentStreak.text!)! / 365
        
        
        self.descStatViewMode.delegate = self
        self.descStatViewMode.dataSource = self
        pickerData = ["Weekly", "Monthly"]
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }
    
    private func configureNavBar(){
        let navController = self.navigationController
        navController?.navigationBar.backgroundColor = .clear
        navController?.navigationBar.tintColor = DARK_GREEN
        navController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:DARK_GREEN]
        // edit button at nav top right
        let nav = self.navigationItem
        let editStatScreen = UIBarButtonItem(title: "profileButton", style: UIBarButtonItem.Style.done, target: self, action: nil)
        editStatScreen.image = UIImage(systemName: "pencil.and.outline")
        editStatScreen.tintColor = DARK_GREEN
        nav.rightBarButtonItem = editStatScreen
        nav.rightBarButtonItem?.action = #selector(buttonPressed)
        nav.rightBarButtonItem?.target = self
    }
    // picker methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        print(pickerData[row])
    }
    
    @objc func buttonPressed(){
        print("Edit button has been pressed")
    }
}
