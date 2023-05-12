//
//  ListObject.swift
//  theMealDB API Dessert App
//
//  Created by Jacob Marillion on 5/11/23.
//

import Foundation

struct topLevelArray: Decodable {
    let meals: [ListObject]
} //End of struct

struct ListObject: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
} //End of struct

struct DetailObject: Decodable {
    let idMeal: String
    let strMeal: String
    //.....
} //End of struct
