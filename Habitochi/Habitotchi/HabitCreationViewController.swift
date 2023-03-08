//
//  HabitCreationViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/1/23.
//

import UIKit

protocol AnimalChanger {
    func changeAnimal(newAnimal: UIImage, newAnimalFileName: String)
}

class HabitCreationViewController: UIViewController, AnimalChanger {

    @IBOutlet weak var saveButton: UIButton!
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
    
    @IBOutlet weak var petNameField: UITextField!
    @IBOutlet weak var AnimalView: UIImageView!
    
    private let createAccountSegueIdentifier = "accountCreateHabitSegueIdentifier"
    var sender = ""
    var animalFileName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        habitNameField.addTarget(self, action: #selector(fieldDidChange(_:)), for: .editingChanged)
        habitDescriptionField.addTarget(self, action: #selector(fieldDidChange(_:)), for: .editingChanged)
        petNameField.addTarget(self, action: #selector(fieldDidChange(_:)), for: .editingChanged)
        
        sundayButton.addTarget(self, action: #selector(fieldDidChange(_:)), for: .touchUpInside)
        mondayButton.addTarget(self, action: #selector(fieldDidChange(_:)), for: .touchUpInside)
        tuesdayButton.addTarget(self, action: #selector(fieldDidChange(_:)), for: .touchUpInside)
        wednesdayButton.addTarget(self, action: #selector(fieldDidChange(_:)), for: .touchUpInside)
        thursdayButton.addTarget(self, action: #selector(fieldDidChange(_:)), for: .touchUpInside)
        fridayButton.addTarget(self, action: #selector(fieldDidChange(_:)), for: .touchUpInside)
        saturdayButton.addTarget(self, action: #selector(fieldDidChange(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }
    
    @objc func fieldDidChange(_ sender: UITextField) {
            if habitNameField.text != "" && habitDescriptionField.text != "" &&
                (sundayButton.isSelected ||
                  mondayButton.isSelected ||
                  tuesdayButton.isSelected ||
                  wednesdayButton.isSelected ||
                  thursdayButton.isSelected ||
                  fridayButton.isSelected ||
                  saturdayButton.isSelected) &&
                petNameField.text != "" &&
                animalFileName != "" {
                saveButton.isEnabled = true;
            } else{
                 saveButton.isEnabled = false;
            }
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
        let habitDescriptionEntered = habitDescriptionField.text ?? ""
        
        // get days of the week selected from buttons
        let daysOfTheWeekSelected = getDaysOfTheWeek()
        if daysOfTheWeekSelected.count == 0{
            let controller = UIAlertController(title: errorTitle, message: "No days selected", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(controller, animated: true)
            
        }
        
        // get the name of the pet, cannot be empty
        let petNameEntered = petNameField.text
        if petNameEntered == nil {
            let controller = UIAlertController(title: errorTitle, message: "Pet Name Field empty", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(controller, animated: true)
        }
        
        let animalImageChosen = AnimalView.image
        
        
        // get time selected from time wheel
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm a"
        let timeEntered = dateFormatter.string(from: notificationTimeField.date)
        
        let animalCreated = Animal(AnimalName: petNameEntered!, spriteName: animalFileName)
        
        let habitCreated = Habit(name: habitNameEntered!, desc: habitDescriptionEntered, reminderDays: daysOfTheWeekSelected, reminderTime: dateFormatter, animal: animalCreated)
        
        currentProfile.addHabit(newHabit: habitCreated)
        
        // #DEBUG#
        currentProfile.printHabits()
        
        self.navigationController?.popViewController(animated: true)
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
        } else {
            navController?.navigationBar.backgroundColor = .white
            navController?.navigationBar.tintColor = DARK_GREEN
            navController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:DARK_GREEN]
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChoosePetSegueIdentifier",
           let destination = segue.destination as? ChoosePetViewController{
            if let sheet = destination.sheetPresentationController{
                sheet.detents = [.medium()]
            }
            destination.delegate = self
        }
    }
    
    func changeAnimal(newAnimal: UIImage, newAnimalFileName: String) {
        AnimalView.image = newAnimal
        animalFileName = newAnimalFileName
        fieldDidChange(habitNameField)
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
