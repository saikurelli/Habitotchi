//
//  HabitCell.swift
//  Habitotchi
//
//  Created by Cole Harper on 4/6/23.
//

import Foundation
import UIKit

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
//
//

            
        }
        
    }
    func updateCell(cell : HabitCell){
        habitCompletionButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        habitCompletionButton.tintColor = DARK_GREEN
        cell.backgroundColor = GREEN
    }
}
    

