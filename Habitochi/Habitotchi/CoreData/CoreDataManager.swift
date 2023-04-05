//
//  CoreDataManager.swift
//  Habitotchi
//
//  Created by Peter on 4/1/23.
//

import Foundation
import CoreData
import UIKit



class CoreDataManager {
    static let dataManager = CoreDataManager()
    
    private let modelName = "Model"
    
    private init() {} // So that the user cannot create another CoreDataManager instance
    
    // setter is private, getter is public. Context needs to be visible publicly
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private(set) var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save() {
        do {
            try context.save()
        } catch {
            print("SAVING FAILURE: Core data has failed to be updated")
        }
    }
    
    // MARK: Profile CRUD Operations
    //------------------------------
    // create a brand-new profile, add it to core data, and return a reference to it
    func createProfile(name: String,
                       image: UIImage = UIImage(systemName: "person.crop.circle")!) -> Profile {
        let createdProfile = Profile(name: name, image: image, context: context)
        save()
        return createdProfile
    }
    
    // fetch (technically) all profiles, but we are enforcing one profile at one time at the moment, so really, fetch the "ONLY" profile in core data :)
    func fetchProfile() -> Profile?{
        do {
            let profiles: [Profile] = try context.fetch(Profile.fetchRequest())
            if profiles.count > 0 { return profiles.first!}
        }
        catch {
            print("Unable to successfully fetch profile from Core Data, regardless if one has been created or not")
        }
        return nil
    }
    
    // update any attribute of a profile
    func updateProfile(profile: Profile,
                       name: String? = nil,
                       image: UIImage? = nil,
                       checkLastOpened: Date? = nil) {
        var edited: Bool = false
        if name != nil {
            profile.name = name!
            edited = true
        }
        if image != nil{
            profile.customProfilePic = true
            profile.profileImage = image!.jpegData(compressionQuality: 0.0)
            edited = true
        }
        if checkLastOpened != nil {
            profile.checkDates(lastOpened: checkLastOpened!)
        }
        
        if edited {save()}
    }
    
    func deleteProfile(profile: Profile) {
        let habits = profile.habits!.array
        
        if habits.count > 0 {
            for case let habit as Habit in habits {
                deleteHabit(habit: habit)
            }
        }
        context.delete(profile)
        save()
    }
    
    // MARK: Habit CRUD Operations
    //------------------------------
    func createHabit(profile: Profile,
                     name: String,
                     desc: String,
                     reminderDays: [String],
                     reminderTime: Date,
                     animal: Animal) -> Habit{
        let habitCreated = Habit(profile: profile, name: name, desc: desc, reminderDays: reminderDays, reminderTime: reminderTime, animal: animal, context: context)
    
        profile.addToHabits(habitCreated)
        save()
        return habitCreated
    }
    
    func fetchAllHabits() -> [Habit]{
        do {
            return try context.fetch(Habit.fetchRequest())
        } catch {
            print("FETCHING FAILURE: Unable to successfully fetch habits")
        }
        return []
    }
    
    func updateHabit(habit: Habit,
                     name: String? = nil,
                     desc: String? = nil,
                     reminderDays: [String]? = nil,
                     reminderTime: Date? = nil,
                     doCheckOffHabit: Bool? = nil,
                     doDailyHabitCheck: Bool? = nil,
                     longestStreak: Int64? = nil) {
        var edited: Bool = false
        if name != nil {
            habit.name = name!
            edited = true
        }
        if desc != nil {
            habit.desc = desc!
            edited = true
        }
        if reminderDays != nil {
            habit.reminderDays = reminderDays!
            edited = true
        }
        if reminderTime != nil {
            habit.reminderTime = reminderTime!
            edited = true
        }
        if doCheckOffHabit != nil {
            habit.habitCircleChecked()
            habit.animal.habitCompleted()
            edited = true
        }
        if longestStreak != nil {
            habit.longestStreak = longestStreak!
            edited = true
        }
        if edited {save()}
    }
    
    // deletes the habit, as well as the animal itself
    func deleteHabit(habit: Habit) {
        deleteAnimal(animal: habit.animal)
        context.delete(habit)
        save()
    }
    
    // MARK: Animal CRUD Operations
    //------------------------------
    
    func createAnimal(name: String,
                      spriteName: String) -> Animal {
        let createdAnimal = Animal(name: name, spriteName: spriteName, context: context)
        save()
        return createdAnimal
    }
    
    // No need for a fetchAnimal. We can access the animal fron the Habit to which it was assigned
    
    func updateAnimal(animal: Animal, name: String, spriteName: String) {
        animal.name = name
        animal.spriteName = spriteName
        animal.sprite = AnimalSprite(imageName: spriteName, name: name)
        save()
    }
    
    private func deleteAnimal(animal: Animal) {
        context.delete(animal)
        //caller must call save instead
    }
    
    public func destroyAllCoreData() {
        guard let url = appDelegate.persistentContainer.persistentStoreDescriptions.first?.url else { return }
        
        let persistentStoreCoordinator = appDelegate.persistentContainer.persistentStoreCoordinator

         do {
             try persistentStoreCoordinator.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
             try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
         } catch {
             print("Attempted to clear persistent store: " + error.localizedDescription)
         }
    }
}
