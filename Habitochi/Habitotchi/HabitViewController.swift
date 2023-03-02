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
    
    @IBAction func buttonPressed(_ sender: Any) {
        fetchedHabit.habitCircleChecked()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
