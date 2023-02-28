//
//  TableViewController.swift
//  Habitochi
//
//  Created by Cole Harper on 2/28/23.
//

import UIKit


class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let textCellIdentifier = "TextCell"
    let tableSegueIdentifier = "HabitTableViewSegueIdentifier"
    var animalSegueIdentifier = ""
   
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tempProfile.habits.count)
        return tempProfile.habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! HabitCell
        
        let row = indexPath.row
        let fetchedHabit = tempProfile.habits[row]
       
        if fetchedHabit.habitCompleted{
            cell.tabelCellImage = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
            cell.tabelCellImage.tintColor = .green
        }
        
        cell.tabelCellImage.tintColor = .green
        //cell.tabelCellImage.backgroundColor = .black
        cell.tableCellLabel.text = fetchedHabit.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        habit1.animal = animal
        tempProfile.habits.append(habit1)
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == tableSegueIdentifier,
           let destination = segue.destination as? HabitViewController,
           let habit = tableView.indexPathForSelectedRow?.row {
            destination.fetchedHabit = tempProfile.habits[habit]
            destination.delegate = self

            
            
        }
        
    }
    

   

}

class HabitCell : UITableViewCell {

    @IBOutlet var tabelCellImage: UIImageView!
    @IBOutlet var tableCellLabel: UILabel!
    
}
