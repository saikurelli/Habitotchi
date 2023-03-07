//
//  SignInViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/2/23.
//

import UIKit

class SignInViewController: UIViewController {

    let segueIdentifier = "accountCreateHabitSegueIdentifier"
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var appleSignInButton: UIButton!
    var profileImage = UIImage(systemName: "person.crop.circle")
    var profileButton:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.tintColor = DARK_GREEN
        appleSignInButton.tintColor = .black
        createProfileButton()
        createButton.isEnabled = false
        nameTextField.addTarget(self, action: #selector(validateNameField), for: .editingChanged)

        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
            currentProfile = Profile(name: nameTextField.text!)
        currentProfile.setProfilePic(image: profileImage!)
        
            print("\(nameTextField.text!)")
        let storyboard = UIStoryboard(name: "HabitCreation", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HabitCreation") as! HabitCreationViewController
            vc.sender = segueIdentifier
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInWithApplePressed(_ sender: Any) {
        let controller = UIAlertController(title: "Button has not been implemented yet", message: "", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(controller, animated: true)
    }
    
    
    @objc func validateNameField(){
        createButton.isEnabled = nameTextField.text != "" ? true : false
    }
    
    func createProfileButton(){
        let profileButton = UIButton(type: .system)
        profileButton.frame = CGRect(x: 160, y: 188, width: 88, height: 88)
        //profileButton.backgroundColor = .black
        profileButton.setBackgroundImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        profileButton.tintColor = .black
        profileButton.isUserInteractionEnabled = true
        profileButton.addTarget(self, action: #selector(profileButtonPressed), for: .touchUpInside)
        self.profileButton = profileButton
        self.view.addSubview(profileButton)
        
    }
    
    @objc func profileButtonPressed(){
        print("selected")
    }
}
