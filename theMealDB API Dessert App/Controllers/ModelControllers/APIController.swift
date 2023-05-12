//
//  JSONObjectsController.swift
//  theMealDB API Dessert App
//
//  Created by Jacob Marillion on 5/11/23.
//

import UIKit

class APIController {
    
    //MARK: - Properties
    static let listEndpoint = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
    static let detailEndpoint = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=")
    
    //MARK: - Helper Functions
    static func fetchDesserts(completion: @escaping (Result<[ListObject], APIError>) -> Void) {
        guard let listEndpoint = listEndpoint else { return completion(.failure(.invalidURL)) }

        URLSession.shared.dataTask(with: listEndpoint) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("POST STATUS CODE: \(response)")
                }
            }
            guard let data = data else { return completion(.failure(.noData)) }

            do {
                let topLevelArray = try JSONDecoder().decode(topLevelArray.self, from: data)
                let dataDict = topLevelArray.meals
                var arrayOfDesserts: [ListObject] = []
                
                for dict in dataDict {
                    let dessert: ListObject = ListObject(strMeal: dict.strMeal, strMealThumb: dict.strMealThumb, idMeal: dict.idMeal)
                    arrayOfDesserts.append(dessert)
                }

                return completion(.success(arrayOfDesserts))
            } catch {
                return completion(.failure(.unableToDecode))
            }
            
        }.resume()
    }
    
    static func fetchOneDessert(id: String, completion: @escaping (Result<[ListObject], APIError>) -> Void) {
        guard let detailEndpoint = detailEndpoint else { return completion(.failure(.invalidURL)) }
        let finalURL = detailEndpoint.appendingPathExtension(id)
        print("zzz \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("POST STATUS CODE: \(response)")
                }
            }
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelArray = try JSONDecoder().decode(topLevelArray.self, from: data)
                let dataDict = topLevelArray.meals
                
                var arrayOfDesserts: [ListObject] = []
                
                for dict in dataDict {
                    let dessert: ListObject = ListObject(strMeal: dict.strMeal, strMealThumb: dict.strMealThumb, idMeal: dict.idMeal)
                    arrayOfDesserts.append(dessert)
                }

                return completion(.success(arrayOfDesserts))
            } catch {
                return completion(.failure(.unableToDecode))
            }
            
        }.resume()
    }
    
    static func fetchThumbnailFor(listObject: ListObject, completion: @escaping (Result<UIImage, APIError>) -> Void) {
        guard let thumbnailURL = URL(string: listObject.strMealThumb) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: thumbnailURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("THUMBNAIL STATUS CODE: \(response.statusCode)")
                }
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            return completion(.success(thumbnail))
            
        }.resume()
    }
    
} //End of class

enum APIError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The server failed to reach the necessary URL."
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -- \(error)"
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "Unable to decode the data"
        }
    }
    
} //End of enum
