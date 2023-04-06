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
    var spkDelegate : SpriteKitViewController!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! HabitCell
        
        let row = indexPath.row
        let fetchedHabit = habits?.object(at: row) as! Habit
        cell.delegate = self
        cell.indexPath = indexPath
        if fetchedHabit.habitCompleted{
            cell.updateCell(cell: cell)
        }else{
            cell.habitCompletionButton.tintColor = GREEN
            cell.backgroundColor = UIColor.clear
            cell.habitCompletionButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        cell.tableCellLabel.text = fetchedHabit.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let habit: Habit = habits?.object(at: indexPath.row) as! Habit
            habits?.remove(habit)
            tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataManager.dataManager.deleteHabit(habit: habit)
            spkDelegate.scene.addedNewSprite()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentProfile.tableDelegate = self
        spkDelegate = currentProfile.skvDelegate
        

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
            destination.fetchedHabit = habits?.object(at: row) as? Habit
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
        let tappedHabit = currentProfile.habits![indexPath.row] as! Habit
        
        
        if !tappedHabit.habitCompleted {
            CoreDataManager.dataManager.updateHabit(habit: tappedHabit, doCheckOffHabit: completed)
            updateCell(cell: self)
        }
        
        }
    func updateCell(cell : HabitCell){
        habitCompletionButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        habitCompletionButton.tintColor = DARK_GREEN
        cell.backgroundColor = GREEN
    }
}
    

