//
//  SignInViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/2/23.
//

import UIKit

class SignInViewController: UIViewController, saveImage {
    

    let segueIdentifier = "accountCreateHabitSegueIdentifier"
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var appleSignInButton: UIButton!
    var profileImage = UIImage(systemName: "person.crop.circle")
    var profileButton:UIButton!
    var profileButtonChanged = false
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.tintColor = DARK_GREEN
        appleSignInButton.tintColor = .black
        createProfileButton()
        createButton.isEnabled = false
        nameTextField.addTarget(self, action: #selector(validateNameField), for: .editingChanged)

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if profileButtonChanged {
            updateProfileButton()
        }
    }
    
    func changeImage(image: UIImage) {
        profileImage = image
        profileButtonChanged = true
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
        let profileButton = RoundButton(frame: CGRect(x: 145, y: 150, width: 132, height: 132))

        //profileButton.backgroundColor = .black
        profileButton.setBackgroundImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        profileButton.tintColor = .black
       // profileButton.contentMode = .center
        profileButton.isUserInteractionEnabled = true
        profileButton.addTarget(self, action: #selector(profileButtonPressed), for: .touchUpInside)
        self.profileButton = profileButton
        self.view.addSubview(profileButton)
        
    }
    
    @objc func profileButtonPressed(){
        let view = ImagePickerViewController()
        view.signInDelegate = self
        let controller = UIAlertController()
        controller.addAction(UIAlertAction(title: "Take Photo", style: .default){_ in
            view.modalPresentationStyle = .fullScreen
            view.cameraMode = true
            view.signin = true
            self.present(view, animated: true)
        })
        controller.addAction(UIAlertAction(title: "Chose a Photo", style: .default){_ in
            view.cameraMode = false
            view.signin = true
            view.modalPresentationStyle = .fullScreen
            self.present(view, animated: false)
        })
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(controller, animated: true)
    }
    
    func updateProfileButton(){
        profileButton.setBackgroundImage(profileImage, for: .normal)
    }
    
        
    }

public protocol saveImage{
    func changeImage(image: UIImage)
}

