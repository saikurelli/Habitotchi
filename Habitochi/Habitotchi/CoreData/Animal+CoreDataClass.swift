//
//  Animal+CoreDataClass.swift
//  Habitotchi
//
//  Created by Peter on 3/27/23.
//
//

import Foundation
import CoreData

@objc(Animal)
public class Animal: NSManagedObject {
    weak var delegate : SpriteKitViewController?
}
