//
//  FavoriteConvenience.swift
//  theMealDB API Dessert App
//
//  Created by Jacob Marillion on 5/11/23.
//

import Foundation
import CoreData

extension Favorite {
    convenience init(id: String, context: NSManagedObjectContext = CoreDataController.context) {
        self.init(context: context)
        self.id = id
    }
} //End of extension
