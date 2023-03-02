//
//  HabitCreationViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/1/23.
//

import UIKit

class HabitCreationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }
    
    private func configureNavBar(){
        let navController = self.navigationController
        navController?.navigationBar.backgroundColor = .white
        navController?.navigationBar.tintColor = DARK_GREEN
        navController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:DARK_GREEN]
        }

}
