//
//  HabitCreationViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/1/23.
//

import UIKit

class HabitCreationViewController: UIViewController {

    private let createAccountSegueIdentifier = "accountCreateHabitSegueIdentifier"
    var sender = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }
    
    private func configureNavBar(){
        let navController = self.navigationController
        
        if sender == createAccountSegueIdentifier{
            self.navigationItem.hidesBackButton = true
        }else{
            navController?.navigationBar.backgroundColor = .white
            navController?.navigationBar.tintColor = DARK_GREEN
            navController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:DARK_GREEN]
        }
        
        }
    
    
//MARK: - Used this function to test the signin screen
//    @IBAction func saveButtonPressed(_ sender: Any) {
//        currentProfile.hardcode()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
//        vc.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    

}
