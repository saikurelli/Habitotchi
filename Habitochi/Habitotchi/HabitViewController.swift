//
//  HabitViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 2/28/23.
//

import UIKit

class HabitViewController: UIViewController {

    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var temp2: UILabel!
    var fetchedHabit = Habit(name: "", goal: "")
    var delegate : UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        temp.text = fetchedHabit.name
        temp2.text = String(fetchedHabit.daysCompleted)


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
