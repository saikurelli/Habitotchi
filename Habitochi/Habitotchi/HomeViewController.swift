// Project: Habitotchi
//  
//  EID: sk49777
//  Course: CS371L


import UIKit
import CoreData

public let DARK_GREEN = UIColor(r: 74, g: 116, b: 21, a: 74)
public let GREEN = UIColor(r: 167, g: 193, b: 129, a: 60)

//quick extension that can be useful for creating custom UIColors
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a/100)
    }
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var spriteKitView: UIView!
    @IBOutlet weak var addHabitButton: UIButton!
    @IBOutlet weak var tableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Playground"
        addHabitButton.tintColor = DARK_GREEN
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }
    
    
    private func configureNavBar(){
        
        let navController = self.navigationController
        self.navigationItem.hidesBackButton = true
        navController?.navigationBar.backgroundColor = DARK_GREEN
        navController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let nav = self.navigationItem
        //need to change this to segue to profile page
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let profileButton = RoundButton(frame: customView.frame)
        profileButton.setBackgroundImage(currentProfile.profileImage, for: .normal)
        profileButton.tintColor = !currentProfile.customProfilePic ? .black : .clear
        profileButton.contentMode = .scaleAspectFit
        profileButton.isUserInteractionEnabled = true
        profileButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        customView.addSubview(profileButton)
        
        
        nav.rightBarButtonItem = UIBarButtonItem(customView: customView)
        }
    
    @objc func buttonClicked(){
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Profile")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}





