//
//  HabitCreationViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/1/23.
//

import UIKit

class HabitCreationViewController: UIViewController {

    @IBOutlet weak var habitNameField: UITextField!
    @IBOutlet weak var habitDescriptionField: UITextField!
    @IBOutlet weak var daysOfTheWeekStack: UIStackView!
    @IBOutlet weak var notificationTimeField: UIDatePicker!
    
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    
    private let createAccountSegueIdentifier = "accountCreateHabitSegueIdentifier"
    var sender = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        // title for alert when user misinputs habit
        let errorTitle = "Missing Field"
        
        // get the name of habit, cannot be empty
        let habitNameEntered = habitNameField.text
        if habitNameEntered == "" {
            let controller = UIAlertController(title: errorTitle, message: "Habit Name Field empty", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(controller, animated: true)
        }
        
        // get habit description
        let habitDescriptionEntered = habitDescriptionField.text
        
        // get days of the week selected from buttons
        let daysOfTheWeekSelected = getDaysOfTheWeek()
        if daysOfTheWeekSelected.count == 0{
            let controller = UIAlertController(title: errorTitle, message: "No days selected", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(controller, animated: true)
            
        }
        
        // get time selected from time wheel
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm a"
        let timeEntered = dateFormatter.string(from: notificationTimeField.date)
        
        let habitCreated = Habit(name: habitNameEntered!, goal: habitDescriptionEntered!)
        
        
    }
    
    // helper methods of reading which buttons were selected
    func getDaysOfTheWeek() -> [String]{
        let daysOfWeek = Calendar.current.weekdaySymbols
        var enteredDaysOfWeek = [String]()
        if sundayButton.isSelected{
            enteredDaysOfWeek.append(daysOfWeek[0])
        }
        if mondayButton.isSelected{
            enteredDaysOfWeek.append(daysOfWeek[1])
        }
        if tuesdayButton.isSelected{
            enteredDaysOfWeek.append(daysOfWeek[2])
        }
        if wednesdayButton.isSelected{
            enteredDaysOfWeek.append(daysOfWeek[3])
        }
        if thursdayButton.isSelected{
            enteredDaysOfWeek.append(daysOfWeek[4])
        }
        if fridayButton.isSelected{
            enteredDaysOfWeek.append(daysOfWeek[5])
        }
        if saturdayButton.isSelected{
            enteredDaysOfWeek.append(daysOfWeek[6])
        }
        
        return enteredDaysOfWeek
        
    }
    
    private func configureNavBar(){
        let navController = self.navigationController
        
        if sender == createAccountSegueIdentifier{
            self.navigationItem.hidesBackButton = true
        }else{
            navController?.navigationBar.backgroundColor = .white
            navController?.navigationBar.tintColor = DARK_GREEN
            navController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:DARK_GREEN]
        }
        
        }
    
    
//MARK: - Used this function to test the signin screen
//    @IBAction func saveButtonPressed(_ sender: Any) {
//        currentProfile.hardcode()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
//        vc.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    

}
