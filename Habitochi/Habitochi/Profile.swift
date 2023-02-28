//
//  Profile.swift
//  Habitochi
//
//  Created by Cole Harper on 2/28/23.
//

import Foundation
import UIKit


//MARK: A basic data structure for a profile, will contain fields for name, profile picture, and habit array?

public class Profile {
    
    var name : String
    var profileImage : UIImage
    var habits : [Habit]
    
    init(name: String) {
        self.name = name
        self.profileImage = UIImage(systemName: "person.circle.fill")!
        self.habits = []
    }
    
    //Function to set profile picture
    func setProfilePic() {
        
    }
    
    //Func that will call initial habit creation VC?
    func setInitialHabit(){
        
    }
    
}
