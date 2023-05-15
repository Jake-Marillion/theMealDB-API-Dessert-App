//
//  theMealDB_API_Dessert_AppTests.swift
//  theMealDB API Dessert AppTests
//
//  Created by Jacob Marillion on 5/11/23.
//

import XCTest
@testable import theMealDB_API_Dessert_App

final class theMealDB_API_Dessert_AppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    //MARK: - CoreData Tests
    func testFavoritesCall() {
        let favorites = CoreDataController.fetchAllFavorites()
        XCTAssertEqual(favorites, ["52768", "52928", "52898", "52893"])
    }

    func testSaveFavorite() {
        let newFavObject: Favorite = Favorite(id: "1234")
        CoreDataController.saveFavorite()

        let favorites = CoreDataController.fetchAllFavorites()
        XCTAssertEqual(favorites.count, 5)
        XCTAssertTrue(favorites.contains("1234"))
    }
    
    func testDeleteFavorite() {
        CoreDataController.deleteFavorite(id: "1234")

        let favorites = CoreDataController.fetchAllFavorites()
        XCTAssertFalse(favorites.contains("1234"))
    }

} //End of class
