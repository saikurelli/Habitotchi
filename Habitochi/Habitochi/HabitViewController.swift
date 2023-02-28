//
//  HabitViewController.swift
//  Habitochi
//
//  Created by Cole Harper on 2/28/23.
//

import UIKit

class HabitViewController: UIViewController {

    @IBOutlet weak var temp: UILabel!
    var t = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        temp.text = t

        // Do any additional setup after loading the view.
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
