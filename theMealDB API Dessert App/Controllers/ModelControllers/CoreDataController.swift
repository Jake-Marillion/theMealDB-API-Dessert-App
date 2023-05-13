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
    
    static var fetchRequestForAll: NSFetchRequest<Favorite> = {
        let request = NSFetchRequest <Favorite>(entityName: "Favorite")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    //MARK: - Helper Functions
    static func fetchAllFavorites() -> [String] {
        let favDict = (try? CoreDataController.context.fetch(fetchRequestForAll)) ?? []
        var favArray: [String] = []
        
        for fav in favDict {
            favArray.append(fav.id ?? "")
        }
        
        return favArray
    }
    
    static func saveFavorite() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    static func deleteFavorite(fav: Favorite) {
        context.delete(fav)
        saveFavorite()
    }
    
} //End of class
