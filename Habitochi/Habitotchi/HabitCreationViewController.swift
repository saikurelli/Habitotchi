//
//  HabitCreationViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/1/23.
//

import UIKit
import CoreData
import SpriteKit

class HabitCreationViewController: UIViewController, AnimalChanger, UITextFieldDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
    var fetchedHabit: Habit? = nil
    var savedAnimal: Animal? = nil


    func setUpEditHabit() {
        // use fetchedHabit to set the fields
        habitNameField.text = fetchedHabit?.name
        habitDescriptionField.text = fetchedHabit?.desc
        petNameField.text = fetchedHabit?.animal.name
        savedAnimal = fetchedHabit?.animal
        saveButton.setTitle("Update", for: .normal)


        // parse out date from time string - 
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
//        let date = dateFormatter.date(from: fetchedHabit!.reminderTime)
        let date = dateFormatter.date(from: dateFormatter.dateFormat)
        notificationTimeField.date = fetchedHabit?.reminderTime ?? dateFormatter.date(from: "2:21 AM")!
        
        for day in fetchedHabit!.reminderDays {
            switch day {
            case "Sunday":
                sundayButton.isSelected = true
            case "Monday":
                mondayButton.isSelected = true
            case "Tuesday":
                tuesdayButton.isSelected = true
            case "Wednesday":
                wednesdayButton.isSelected = true
            case "Thursday":
                thursdayButton.isSelected = true
            case "Friday":
                fridayButton.isSelected = true
            case "Saturday":
                saturdayButton.isSelected = true
            default:
                print("Error: day not found")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // if fetchedHabit is not nil, want to set the fields to the habit's values
        if fetchedHabit != nil {
            setUpEditHabit()
        }
        saveButton.isEnabled = false
        
        habitNameField.addTarget(self, action: #selector(fieldDidChange(_:)), for: .editingChanged)
        habitDescriptionField.addTarget(self, action: #selector(fieldDidChange(_:)), for: .editingChanged)
        petNameField.addTarget(self, action: #selector(fieldDidChange(_:)), for: .editingChanged)
        
        habitNameField.delegate = self
        habitDescriptionField.delegate = self
        petNameField.delegate = self
        
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
                (animalFileName != "" || savedAnimal != nil) {
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
        
        // get time selected from time wheel
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm a"
//        let timeEntered: NSDate? = dateFormatter.string(from: notificationTimeField.date as Date)
        
        let timeEntered = notificationTimeField.date
        
        var animalCreated: Animal
        // CREATE ANIMAL
        if savedAnimal == nil && AnimalView.image != nil  {
            let animalImageChosen = AnimalView.image
            animalCreated = CoreDataManager.dataManager.createAnimal(name: petNameEntered!, spriteName: animalFileName)
        // UPDATE ANIMAL
        } else {
            animalCreated = savedAnimal!
            animalCreated.sprite?.animalTexture = SKTexture(imageNamed: animalFileName)
            CoreDataManager.dataManager.updateAnimal(animal: animalCreated, name: petNameEntered!, spriteName: animalFileName)
        }
        
        // UPDATE HABIT
        if let fetchedHabit {
            // TODO: Can refactor to be more efficient
            CoreDataManager.dataManager.updateHabit(habit: fetchedHabit, name: habitNameEntered!, desc: habitNameEntered, reminderDays: daysOfTheWeekSelected, reminderTime: timeEntered)
        // CREATE HABIT
        } else {
            let habitCreated = CoreDataManager.dataManager.createHabit(profile: currentProfile, name: habitNameEntered!, desc: habitDescriptionEntered, reminderDays: daysOfTheWeekSelected, reminderTime: timeEntered, animal: animalCreated)
            createNotificationScheme(habit: habitCreated)
        }
        
//
//        let animalCreated = Animal(AnimalName: petNameEntered!, spriteName: animalFileName, context: context)
//
//        let habitCreated = Habit(name: habitNameEntered!, desc: habitDescriptionEntered, reminderDays: daysOfTheWeekSelected, reminderTime: timeEntered, animal: animalCreated, context: context)
//        animalCreated.habit = habitCreated // set the inverse relationship denoting aninmal <-> habit.
//
//        currentProfile.addToHabits(habitCreated) // set the one-to-many relationship denoting profile <-> habit
//        habitCreated.profile = currentProfile // set the inverse relationship denoting profile <-> habit
//
//        do {
//            try context.save()
//        } catch {
//            print("SAVING FAILURE: Habit has failed to be created and saved to core data")
//        }
//>>>>>>> Stashed changes
        
        currentProfile.addedOrEditedHabit = true
        
        if self.sender == createAccountSegueIdentifier {
            navigateToHomeScreen()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func navigateToHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
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
            navController?.navigationBar.backgroundColor = .clear
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
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func createNotificationScheme(habit : Habit){
        let content = UNMutableNotificationContent()
        content.title = "Don't forget to complete \(habit.name)!"
        content.subtitle = ""
        content.sound = .default
        
        let notifcationCenter = UNUserNotificationCenter.current()
        
//        print(habit.reminderTime)
      
        var dateComp = DateComponents()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        let (hour, minute) = checkHour(time: dateFormatter.string(from: habit.reminderTime!))
        dateComp.calendar = Calendar.current
        for day in habit.reminderDays {
            switch day {
            case "Sunday":
                dateComp.weekday = 1
            case "Monday":
                dateComp.weekday = 2
            case "Tuesday":
                dateComp.weekday = 3
            case "Wednesday":
                dateComp.weekday = 4
            case "Thursday":
                dateComp.weekday = 5
            case "Friday":
                dateComp.weekday = 6
            default:
                dateComp.weekday = 7
            }

            dateComp.hour = hour
            dateComp.minute = minute
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
            let request = UNNotificationRequest(identifier: "\(habit.name) - \(dateComp.weekday!)", content: content, trigger: trigger)
            notifcationCenter.add(request){ (error) in
                if error != nil {
                    print("Error adding reminder")
                }
                
            }
                

        }
    }
    
    func checkHour(time : String) -> (Int, Int){
        
        let timeComps = time.components(separatedBy: " ")
        let time = timeComps[0].components(separatedBy: ":")
        
        let hour = Int(time[0])
        let minute = Int(time[1])
        return(hour!, minute!)
    }
    
    
    

}
