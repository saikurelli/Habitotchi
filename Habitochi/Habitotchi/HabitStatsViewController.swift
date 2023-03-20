//
//  HabitViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 2/28/23.
//

import UIKit
import SwiftUI
import SpriteKit

class HabitStatsViewController: UIViewController{
    
    @IBOutlet weak var animalSprite: SKView!
    
    var pickerData: [String] = [String]()
    
    @IBOutlet weak var habitLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    var fetchedHabit = Habit(name: "", desc: "", reminderDays: [], reminderTime: DateFormatter(), animal: Animal())
    
    var delegate : UIViewController!
    
    @IBOutlet weak var longestStreak: UILabel!
    @IBOutlet weak var currentStreak: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up Sprite Animal
        let scene = SKScene(size: animalSprite.bounds.size)
        scene.backgroundColor = UIColor.clear
        self.view.bounds = UIScreen.main.bounds
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.addChild(fetchedHabit.animal.sprite.createSprite(size: animalSprite.bounds.size))
        animalSprite.presentScene(scene)
        animalSprite.backgroundColor = UIColor.clear
        
        // set up labels
        habitLabel.text = fetchedHabit.name
        currentStreak.text = String(fetchedHabit.daysCompleted)
        descLabel.text = fetchedHabit.desc
        longestStreak.text = String(0)
        
        
//        self.descStatViewMode.delegate = self
//        self.descStatViewMode.dataSource = self
//        pickerData = ["Weekly", "Monthly"]
        
        // Do any additional setup after loading the view.
        renderSwiftCircularProgressBar()
        renderSwiftMenu()
        
        
    }
    
    func renderSwiftCircularProgressBar() {
         
        let vc = UIHostingController(rootView: CircularProgressBar(count: fetchedHabit.daysCompleted))
        let switftUIView = vc.view!
        // add Views to hierarchy
        switftUIView.translatesAutoresizingMaskIntoConstraints = false
        addChild(vc)
        view.addSubview(switftUIView)
        
        let constraints = [
            switftUIView.topAnchor.constraint(equalTo: currentStreak.topAnchor, constant: 60),
            switftUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ]
        // add constraints
        NSLayoutConstraint.activate(constraints)
        vc.didMove(toParent: self)
    }
    
    func renderSwiftMenu() {
         
        let vc = UIHostingController(rootView: MenuBar(delegate: self))
        let switftUIView = vc.view!
        // add Views to hierarchy
        switftUIView.translatesAutoresizingMaskIntoConstraints = false
        addChild(vc)
        view.addSubview(switftUIView)
        
        let constraints = [
            switftUIView.topAnchor.constraint(equalTo:  habitLabel.topAnchor),
            switftUIView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 50)
            
        ]
        // add constraints
        NSLayoutConstraint.activate(constraints)
        vc.didMove(toParent: self)
    }
    
    func clearCalendarBox() {
        let vc = UIHostingController(rootView: Rectangle().foregroundColor(.clear)
            .frame(width: 600, height: 170))
        
        let switftUIView = vc.view!
        // add Views to hierarchy
        switftUIView.translatesAutoresizingMaskIntoConstraints = false
        addChild(vc)
        view.addSubview(switftUIView)
        
        let constraints = [
            switftUIView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10),
            switftUIView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -150)

        ]
        // add constraints
        NSLayoutConstraint.activate(constraints)
        vc.didMove(toParent: self)
    }
    
    
    func renderSwiftCalendar(weekMode: Bool) {
        let vc = UIHostingController(rootView: CalendarElem(weekMode: weekMode)
            .frame(width: 400.0).foregroundColor(.blue))
        
        let switftUIView = vc.view!
        // add Views to hierarchy
        switftUIView.translatesAutoresizingMaskIntoConstraints = false
        addChild(vc)
        view.addSubview(switftUIView)
        
        let constraints = [
            switftUIView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10),
            switftUIView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -150)

        ]
        // add constraints
        NSLayoutConstraint.activate(constraints)
        vc.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }
    
    private func configureNavBar() {
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
    
    @objc func buttonPressed(){
        print("Edit button has been pressed")
    }
}
