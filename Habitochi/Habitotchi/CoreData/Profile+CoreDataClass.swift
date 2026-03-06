//
//  Profile+CoreDataClass.swift
//  Habitotchi
//
//  Created by Peter on 3/27/23.
//
//

import Foundation
import CoreData

@objc(Profile)
public class Profile: NSManagedObject {
    var addedOrEditedHabit: Bool = false
    var displayHabitAlert: Bool = true
    weak var tableDelegate : TableViewController?
    weak var skvDelegate : SpriteKitViewController?
}
