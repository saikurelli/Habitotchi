//
//  TableViewController.swift
//  Habitochi
//
//  Created by Cole Harper on 2/28/23.
//

import UIKit

public let temp = ["test1", "test2", "test3"]


class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    let tableSegueIdentifier = "HabitTableViewSegueIdentifier"
    var animalSegueIdentifier = ""
   
    @IBOutlet var tableVIew: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIew.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath as IndexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = temp[row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableVIew.delegate = self
        tableVIew.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == tableSegueIdentifier,
           let destination = segue.destination as? HabitViewController,
           let habit = tableVIew.indexPathForSelectedRow?.row {
            destination.t = temp[habit]
            
        }
        
    }
    

   

}
