//
//  FetchRecipeAppTests.swift
//  FetchRecipeAppTests
//
//  Created by Christian Pichardo on 5/16/23.
//

import XCTest
import Combine
@testable import FetchRecipeApp

final class FetchRecipeAppTests: XCTestCase {
    
    private var vm:MealsViewModel!
    
    // Make function for this
    // Replace with a dummy network service eventually
    private var ids = Set(["53049", "52893", "52768", "52767", "52855", "52894", "52928", "52891", "52792", "52961", "52923", "52897", "52976", "52898", "52910", "52856", "52853", "52966", "52776", "52860", "52905", "52990", "52788", "52989", "52988", "52899", "52888", "52791", "53007", "52787", "52890", "52859", "53015", "52900", "52991", "52924", "52858", "52854", "52902", "52862", "52861", "52958", "52916", "53022", "53046", "52932", "52857", "52901", "52786", "53024", "52833", "53054", "52886", "52883", "52793", "53005", "52931", "52889", "52909", "52929", "52892", "52970", "53062", "52917"])
    
    override func setUp() async throws {
        vm = .init(test:true)
    }
    
    override func tearDown() {
        vm = nil
    }
    
    // init()
    func test_meals_initial_is_empty() {
        XCTAssertTrue(
            vm.meals.isEmpty,
            "Expected initial value to be empty, but got \(vm.meals)."
        )
    }
    
    // downloadData()
    func test_successful_download_data_function()  {
        let expectation = XCTestExpectation(description: "Make an async network call")
        
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        
        vm.downloadData(fromURL: url) { data in
          
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        
        wait(for:[expectation], timeout: 10)
        
    }
    
    func test_unsuccessful_download_data_function()  {
        let expectation = XCTestExpectation(description: "Make an unsucessful network call")
        
        // random url
        guard let url = URL(string:"https://sfasdfdfadfasdfaf.com") else {
            return
        }
        
        vm.downloadData(fromURL:url) { data in
            expectation.fulfill()
            XCTAssertNil(data)
        }
        
        wait(for:[expectation], timeout: 10)
    }
    
    // fetchMealInstructions()
    func test_successful_fetch_meal_instructions_function() {
        let expectation = XCTestExpectation(description: "Make sure that meal is added to publisher")
        
        // Test for adding one meal
        let listener = vm.$meals
            .dropFirst()
            .sink(receiveValue: {
                XCTAssert($0.count == 1,
                          "Count was : \($0.count)")
                expectation.fulfill()
            })
        
        // Fetch the instructions for the given mealID
        vm.fetchMealInstructions(mealID: "52901")
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssert(vm.meals.count == 1, "Count was : \(vm.meals.count)")
        listener.cancel()
    }
    
    func test_fetch_multiple_meal_instructions(){
        let expectation = XCTestExpectation(description: "Make sure meals are added")
        
        // Test for adding multiple meal instructions
        let listener = vm.$meals
            .dropFirst()
            .sink(receiveValue: {
                if $0.count == 6{
                    expectation.fulfill()
                }
            })
        
        vm.fetchMealInstructions(mealID: "53049")
        vm.fetchMealInstructions(mealID: "52893")
        vm.fetchMealInstructions(mealID: "52891")
        vm.fetchMealInstructions(mealID: "52855")
        vm.fetchMealInstructions(mealID: "52791")
        vm.fetchMealInstructions(mealID: "52990")
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(vm.meals.count, 6)
        listener.cancel()
        
    }
    
    func test_fetch_multiple_meal_instructions_are_sorted(){
        let expectation = XCTestExpectation(description: "Make sure meals are sorted")
        
        // Test for adding multiple meal instructions
        let listener = vm.$meals
            .dropFirst()
            .sink(receiveValue: {
                if $0.count == 6{
                    var prev = $0[0]
                    // I am doing count -1 because I sort after I add to list
                    for i in 1..<$0.count-1 {
                        if $0[i].strMeal < prev.strMeal{
                            XCTFail("Not in in alpha order")
                        }
                        prev = $0[i]
                    }
                    expectation.fulfill()
                }
            })
        
        vm.fetchMealInstructions(mealID: "53049")
        vm.fetchMealInstructions(mealID: "52893")
        vm.fetchMealInstructions(mealID: "52891")
        vm.fetchMealInstructions(mealID: "52855")
        vm.fetchMealInstructions(mealID: "52791")
        vm.fetchMealInstructions(mealID: "52990")
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(vm.meals.count, 6)
        listener.cancel()
        
    }
    
    // filterIngredients()
    func test_filter_ingredients_with_no_nulls_but_empty_strings(){
        let meal =
            MealInstructionsModel(strMeal: "Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "12345", strArea: "America", strInstructions: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", filteredIngredients: [], formattedInstructions: [])
        
        // Filter the instructions for this model. It will go through all
        // the ingredient and measure properties
        let result = vm.filterIngredients(meal:meal)
        
        // Should be empty because properties are empty
        XCTAssert(result == ["Ingredients not found"],
                  "Result was: \(result)")
        
    }

    func test_filter_ingredients_with_nulls_and_empty_strings(){
        
        let meal =
            MealInstructionsModel(strMeal: "Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "12345", strArea: "America", strInstructions: "", strIngredient1: nil, strIngredient2: "", strIngredient3: "", strIngredient4: nil, strIngredient5: "", strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: nil, strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "ing19", strIngredient20: "", strMeasure1: "m1", strMeasure2: "m2", strMeasure3: "m3", strMeasure4: "m4", strMeasure5: nil, strMeasure6: nil, strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: nil, strMeasure18: "", strMeasure19: "", strMeasure20: "", filteredIngredients: [], formattedInstructions: [])
        
        // Filter the instructions for this model. It will go through all
        // the ingredient and measure properties
        let result = vm.filterIngredients(meal:meal)
        
        // Should be empty because there were no (strIngx, strMeasx) pair
        // with valid elements
        XCTAssert(result == ["Ingredients not found"],
                  "Result was: \(result)")
        
    }
    
    func test_filter_ingredients_with_no_nulls_but_valid_strings(){
        
        let meal =
            MealInstructionsModel(strMeal: "Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "12345", strArea: "America", strInstructions: "", strIngredient1: "ing1", strIngredient2: "ing2", strIngredient3: "ing3", strIngredient4: "ing4", strIngredient5: "ing5", strIngredient6: "ing6", strIngredient7: "ing7", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "m1", strMeasure2: "m2", strMeasure3: "m3", strMeasure4: "m4", strMeasure5: "m5", strMeasure6: "m6", strMeasure7: "m7", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", filteredIngredients: [], formattedInstructions: [])
        
        // Filter the instructions for this model. It will go through all
        // the ingredient and measure properties
        let result = vm.filterIngredients(meal:meal)
        
        // Should not be empty because there were 7 (strIngx, strMeasx) pairs with valid elements
        XCTAssert(result.count == 7, "Result was: \(result)")
        
    }
    
    func test_filter_ingredients_with_nulls_and_valid_strings(){
        
        let meal =
            MealInstructionsModel(strMeal: "Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "12345", strArea: "America", strInstructions: "", strIngredient1: "ing1", strIngredient2: "ing2", strIngredient3: "ing3", strIngredient4: "ing4", strIngredient5: "ing5", strIngredient6: "ing6", strIngredient7: "ing7", strIngredient8: "ing8", strIngredient9: "ing9", strIngredient10: "ing10", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "m1", strMeasure2: "m2", strMeasure3: "m3", strMeasure4: "m4", strMeasure5: "m5", strMeasure6: nil, strMeasure7: "m7", strMeasure8: nil, strMeasure9: nil, strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", filteredIngredients: [], formattedInstructions: [])
        
        // Filter the instructions for this model. It will go through all
        // the ingredient and measure properties
        let result = vm.filterIngredients(meal:meal)
        
        // Should be empty because properties are empty
        XCTAssert(result.count == 6, "Result was: \(result)")
        
    }
    
    // formatInstructions()
    func test_format_intstructions_empty_string(){
        
        let meal =
            MealInstructionsModel(strMeal: "Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "12345", strArea: "America", strInstructions: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", filteredIngredients: [], formattedInstructions: [])
        
        // Takes the string and turns it into a list separated by \n and \r
        let result = vm.formatInstructions(meal: meal)
        
        XCTAssert(result == ["Instructions not found"],
            "Result list was \(result)")
    }
    
    func test_format_intstructions_null_string(){
        
        let meal =
            MealInstructionsModel(strMeal: "Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "12345", strArea: "America", strInstructions: nil, strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", filteredIngredients: [], formattedInstructions: [])
        
        // Takes the string and turns it into a list separated by \n and \r
        let result = vm.formatInstructions(meal: meal)
        
        XCTAssert(result == ["Instructions not found"],
            "Result list was \(result)")
    }
    
    func test_format_twenty_intstructions(){
        
        var string = ""
        for i in 0..<20{
            string.append("step\(i+1)\n\r\n\r\n\r")
        }
        
        let meal =
            MealInstructionsModel(strMeal: "Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "12345", strArea: "America", strInstructions: string, strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", filteredIngredients: [], formattedInstructions: [])
        
        // Takes the string and turns it into a list separated by \n and \r
        let result = vm.formatInstructions(meal: meal)
        
        XCTAssert(result.count == 20,
            "Result list was \(result)")
    }

}
