//
//  ProfileViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/7/23.
//

import UIKit

class ProfileViewController: UIViewController, saveImage {
    
    var tempImage : UIImage!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpViews()
    }
    
    private func configureNavBar(){
        let navController = self.navigationController
        navController?.navigationBar.backgroundColor = .clear
        navController?.navigationBar.tintColor = DARK_GREEN
        navController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:DARK_GREEN]
        // edit button at nav top right
        let nav = self.navigationItem
        let editStatScreen = UIBarButtonItem(title: "editButton", style: UIBarButtonItem.Style.done, target: self, action: nil)
        editStatScreen.image = UIImage(systemName: "pencil.and.outline")
        editStatScreen.tintColor = DARK_GREEN
        nav.rightBarButtonItem = editStatScreen
        nav.rightBarButtonItem?.action = #selector(buttonPressed)
        nav.rightBarButtonItem?.target = self
    }
    
    
    @objc func buttonPressed(){
        let controller = UIAlertController()
        controller.addAction(UIAlertAction(title: "Change Profile Picture", style: .default){ _ in
            self.changeProfilePicture()
        })
        controller.addAction(UIAlertAction(title: "Change Name", style: .default) { _ in
            self.changeName()
        })
        controller.addAction(UIAlertAction(title: "Delete Profile", style: .destructive))
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(controller, animated: true)
    }
    
    func setUpViews(){
        let profilePicture = CircularImageView(frame: CGRect(x: 94, y: 130, width: 200, height: 200))
        profilePicture.image = currentProfile.profileImage
        if !currentProfile.customProfilePic{
            profilePicture.tintColor = .black
        }
        profilePicture.contentMode = .scaleAspectFill
        self.view.addSubview(profilePicture)
        nameLabel.text = currentProfile.name
    }
    
    func changeProfilePicture(){
        let controller = UIAlertController()
        controller.addAction(UIAlertAction(title: "Take Photo", style: .default){ _ in
            let vc = ImagePickerViewController()
            vc.profileEditDelegate = self
            vc.cameraMode = true
            vc.signin = false
            self.present(vc, animated: false)
        })
        controller.addAction(UIAlertAction(title: "Chose a Photo", style: .default){ _ in
            let vc = ImagePickerViewController()
            vc.profileEditDelegate = self
            vc.cameraMode = false
            vc.signin = false
            self.present(vc, animated: false)
        })
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(controller, animated: true)
        
    }
    
    func changeName(){
        let controller = UIAlertController(title: "Change Name", message: "", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        controller.addTextField(configurationHandler: {
            (textField) in textField.placeholder = "Enter your name"
        } )
        
        controller.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: {
                (action) in let enteredText = controller.textFields![0].text
                currentProfile.setName(name: enteredText!)
                self.setUpViews()
            } ))
                               
        present(controller, animated: true)
        
    }
    
    func changeImage(image: UIImage) {
        currentProfile.setProfilePic(image: image)
        setUpViews()
    }
    
    

    
    
}
