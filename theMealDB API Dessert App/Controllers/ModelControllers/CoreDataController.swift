//
//  CoreDataController.swift
//  theMealDB API Dessert App
//
//  Created by Jacob Marillion on 5/11/23.
//

import Foundation
import CoreData

class CoreDataController {
    
    //MARK: - Properties
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "theMealDB_API_Dessert_App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    static var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    //MARK: - Favorites
    static func saveFavorite() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    static func deleteFavorite(id: String) {
        let favToDelete: Favorite = Favorite(id: id)
        context.delete(favToDelete)
        saveFavorite()
    }
    
} //End of class
