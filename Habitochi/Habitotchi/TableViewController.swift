//
//  TableViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 2/28/23.
//

import UIKit


class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let textCellIdentifier = "TextCell"
    let tableSegueIdentifier = "HabitTableViewSegueIdentifier"
    let habitCreationSegueIdentifier = "habitCreationSegueIdentifier"
    
    let habits = currentProfile.habits
   
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var addHabitButton: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! HabitCell
        
        let row = indexPath.row
        let fetchedHabit: Habit = habits?.object(at: row) as! Habit
        cell.delegate = self
        cell.indexPath = indexPath
        if cell.completed{
            cell.habitCompletionButton.tintColor = DARK_GREEN
        }else{
            cell.habitCompletionButton.tintColor = GREEN
        }
        cell.tableCellLabel.text = fetchedHabit.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func changeTableCellBackground(tableView : UITableView, indexPath : IndexPath, checked: Bool){
        
        let cell = tableView.cellForRow(at: indexPath)
        if checked{
            cell?.backgroundColor = GREEN
        }
        else{
            cell?.backgroundColor = .white
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == tableSegueIdentifier,
           let destination = segue.destination as? HabitStatsViewController,
           let row = tableView.indexPathForSelectedRow?.row {
            destination.fetchedHabit = habits?.object(at: row) as! Habit
            destination.delegate = self
        }
    }
    


   

}

class HabitCell : UITableViewCell {
    
    
    @IBOutlet weak var habitCompletionButton: UIButton!
    @IBOutlet var tableCellLabel: UILabel!
    var completed = false
    var delegate : TableViewController!
    var indexPath : IndexPath!
    
    @IBAction func buttonPressed(_ sender: Any) {
        //need to be able to reset it at beginning of new day
        
        // fetch all habits related to this profile
        let habit = NSPredicate(format:"ANY Habit == %@", currentProfile)
        

        if !completed {
            completed = true
            
            habitCompletionButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            habitCompletionButton.tintColor = DARK_GREEN
            delegate.changeTableCellBackground(tableView: delegate.tableView, indexPath: indexPath, checked: true)
            
        }
        
//        else if completed {
//            completed = false
//            habitCompletionButton.setImage(UIImage(systemName: "circle"), for: .normal)
//            habitCompletionButton.tintColor = GREEN
//            if habit != nil {
//                habit!.habitCircleUnchecked()
//            }else{
//                print("ERROR HABIT CELL")
//            }
//            delegate.changeTableCellBackground(tableView: delegate.tableView, indexPath: indexPath, checked: false)
//
//
//        }
        
    }
}
    

