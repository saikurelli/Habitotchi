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
        // fetch all habits related to this profile then get current habit
        let tappedHabit = currentProfile.habits![indexPath.row] as! Habit

        if !tappedHabit.habitCompleted {
            // have a ui alert to confirm that they want to complete the habit
            let alert = UIAlertController(title: "Confirm Habit Completion", message: "Did you complete \(tappedHabit.name) today?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                CoreDataManager.dataManager.updateHabit(habit: tappedHabit, doCheckOffHabit: true)
                self.updateCell(cell: self)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.delegate.present(alert, animated: true)
        }

    }
    func updateCell(cell : HabitCell){
        habitCompletionButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        habitCompletionButton.tintColor = DARK_GREEN
        cell.backgroundColor = GREEN
    }
}
