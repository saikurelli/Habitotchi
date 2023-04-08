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
    
    var fetchedHabit: Habit!
    
    @IBOutlet weak var animalSprite: SKView!
    
    var pickerData: [String] = [String]()
    
    @IBOutlet weak var habitLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    var delegate : UIViewController!
    
    @IBOutlet weak var longestStreak: UILabel!
    @IBOutlet weak var currentStreak: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        renderSwiftCircularProgressBar()
        renderSwiftMenu()
    }
    
    func renderSwiftCircularProgressBar() {
         
        let vc = UIHostingController(rootView: CircularProgressBar(count: Int(fetchedHabit.daysCompleted), creationDate: fetchedHabit.habitCreationDate))
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
    
    // MARK: - Get dates in last K days for Calendar Data
    func getDatesInLastKDays(completedDays: [String], K: Int) -> [Bool] {
        var returnDates = [Bool](repeating: false, count: K)
        // start from back of completedDays and set date difference to true if less than K days, else break
        for i in stride(from: completedDays.count - 1, through: 0, by: -1) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            let date = dateFormatter.date(from: completedDays[i])
            let dateOffset = Calendar.current.dateComponents([.day], from: date!, to: Date())
            if dateOffset.day! < K {
                returnDates[K - 1 - dateOffset.day!] = true
            } else {
                break
            }
        }
        return returnDates
    }

    // Header string for the calendar where the last element is the current day
    func generateHeader() -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        var header : [String] = []
        var day = dateFormatter.string(from: Date())


        for _ in 0..<7 {
            header.append(day.uppercased().prefix(3).description)
            day = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: dateFormatter.date(from: day)!)!)
        }
        return header.reversed()
    }

    func renderSwiftCalendar(weekMode: Bool) {
        // get dates in last seven days habit successfully completed
        let weekCompletion = getDatesInLastKDays(completedDays: fetchedHabit.habitCompletedDays, K: 7)
        let monthCompletion = getDatesInLastKDays(completedDays: fetchedHabit.habitCompletedDays, K: 30)
        let header = generateHeader()
//        print("Week Completion \(weekCompletion)")
        let vc = UIHostingController(rootView: CalendarElem(weekMode: weekMode, weekChecks: weekCompletion, monthChecks: monthCompletion, header: header)
            .frame(width: 400.0).foregroundColor(.blue))
        
        let switftUIView = vc.view!
        switftUIView.backgroundColor = UIColor.clear
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
        // setting up Sprite Animal
        let scene = SKScene(size: animalSprite.bounds.size)
        scene.backgroundColor = UIColor.clear
        self.view.bounds = UIScreen.main.bounds
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.addChild(fetchedHabit.animal.sprite!.createSprite(size: animalSprite.bounds.size, spriteName: fetchedHabit.animal.spriteName!))
        animalSprite.presentScene(scene)
        animalSprite.backgroundColor = UIColor.clear
        
        // set up labels
        habitLabel.text = fetchedHabit.name
        currentStreak.text = String(fetchedHabit.streak)
        descLabel.text = fetchedHabit.desc
        longestStreak.text = String(fetchedHabit.longestStreak)
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
        // navigate to create habit screen with habit data
        let storyboard = UIStoryboard(name: "HabitCreation", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "HabitCreation") as HabitCreationViewController
        vc.fetchedHabit = fetchedHabit
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
