//
//  SignInViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/2/23.
//

import UIKit

class SignInViewController: UIViewController, saveImage, UITextFieldDelegate {
    

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
        nameTextField.delegate = self

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
            if profileButtonChanged {
                currentProfile.setProfilePic(image: profileImage!)
            }
        
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
        profileButton.contentMode = .scaleAspectFill
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
            view.isModalInPresentation = true
            view.cameraMode = true
            view.signin = true
            view.view.isOpaque = false
            view.view.backgroundColor = .clear
            self.present(view, animated: true)
        })
        controller.addAction(UIAlertAction(title: "Choose a Photo", style: .default){_ in
            view.cameraMode = false
            view.signin = true
            view.modalPresentationStyle = .fullScreen
            view.isModalInPresentation = true
            view.view.isOpaque = false
            view.view.backgroundColor = .clear
            self.present(view, animated: false)
        })
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(controller, animated: true)
    }
    
    func updateProfileButton(){
        profileButton.setBackgroundImage(profileImage, for: .normal)
        profileButton.imageView!.contentMode = .scaleAspectFill
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
        
    }




