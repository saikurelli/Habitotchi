//
//  SignInViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/2/23.
//

import UIKit

class SignInViewController: UIViewController {

    let segueIdentifier = "accountCreateHabitSegueIdentifier"
    @IBOutlet weak var profilePictureButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "accountCreateHabitSegueIdentifier",
//           let destination = segue.destination as? HabitCreationViewController{
//            destination.sender = segue.identifier!
//        }
//    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        if nameTextField.text != ""{
            currentProfile = Profile(name: nameTextField.text!)
            print("\(nameTextField.text!)")
        let storyboard = UIStoryboard(name: "HabitCreation", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HabitCreation") as! HabitCreationViewController
            
            vc.sender = segueIdentifier
        
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            print("error")
        }
    }
    
}
