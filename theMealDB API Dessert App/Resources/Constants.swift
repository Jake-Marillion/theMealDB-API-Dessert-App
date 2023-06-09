//
//  Constants.swift
//  theMealDB API Dessert App
//
//  Created by Jacob Marillion on 5/11/23.
//

import Foundation

struct K {
    //MARK: - General
    static let emptyString = ""
    static let filledHeart = "heart.fill"
    static let heart = "heart"
    static let keyPath = "position"
    static let ok = "Ok"
    
    //MARK: - API
    static let listURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    static let detailURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    //MARK: - CoreData
    static let containerName = "theMealDB_API_Dessert_App"
    static let entityName = "Favorite"
    
    //MARK: - ListTableViewController
    static let nibName = "DessertTableViewCell"
    static let customCellId = "CustomDessertCell"
    static let toDetailSegueId = "toDetailVC"
    static let listErrorAlertTitle = "There was an error fetching desserts."
    static let listErrorAlertMessage = "Please check your connection and re-open the app."
    
    //MARK: - DetailViewController
    static let navBarTitle = "Desserts"
    static let defaultImageName = "photo.on.rectangle"
    static let detailErrorAlertTitle = "There was an error fetching this dessert."
    static let detailErrorAlertMessage = "Please check your connection and re-open the app."
    
    
} //End of struct
