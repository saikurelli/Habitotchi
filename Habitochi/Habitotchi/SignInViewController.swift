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
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var appleSignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.tintColor = DARK_GREEN
        appleSignInButton.tintColor = .black

        // Do any additional setup after loading the view.
        
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "accountCreateHabitSegueIdentifier",
//           let destination = segue.destination as? HabitCreationViewController{
//            destination.sender = segue.identifier!
//        }
//    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        let errorTitle = "Missing Field"
        
        
        if nameTextField.text == ""{
            let controller = UIAlertController(title: errorTitle, message: "Please enter your name", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(controller, animated: true)

        }else{
            currentProfile = Profile(name: nameTextField.text!)
            print("\(nameTextField.text!)")
        let storyboard = UIStoryboard(name: "HabitCreation", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HabitCreation") as! HabitCreationViewController
            
            vc.sender = segueIdentifier
        
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
