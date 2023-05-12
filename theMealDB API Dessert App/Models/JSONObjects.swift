//
//  ListObject.swift
//  theMealDB API Dessert App
//
//  Created by Jacob Marillion on 5/11/23.
//

import Foundation

struct topLevelAray: Decodable {
    let children: [ListObject]
} //End of struct

struct ListObject: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
} //End of struct
