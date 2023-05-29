//
//  EndpointTests.swift
//  FetchRecipeAppTests
//
//  Created by Christian Pichardo on 5/29/23.
//

import XCTest
@testable import FetchRecipeApp

final class EndpointTests: XCTestCase {

    func test_with_lookup_by_id_request_is_valid()  {
        let endpoint = Endpoint.lookupByID(matching: "12345")
        
        XCTAssertEqual(endpoint.host, "www.themealdb.com",
                       "The host should be www.themealdb.com, it was \(endpoint.host)")
        XCTAssertEqual(endpoint.path, "/api/json/v1/1/lookup.php",
                       "The path should be /api/json/v1/1/lookup.php, it was \(endpoint.path)")
        XCTAssertEqual(endpoint.queryItems, [URLQueryItem(name:"i", value:"12345")],
                       "The the query items should be i:12345")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://www.themealdb.com/api/json/v1/1/lookup.php?i=12345",
            "The url was \(endpoint.url?.absoluteString ?? "nil")")
    }
    
    func test_with_filter_by_category_request_is_valid()  {
        let endpoint = Endpoint.filterByCategory(matching: "Dessert")
        
        XCTAssertEqual(endpoint.host, "www.themealdb.com",
                       "The host should be www.themealdb.com, it was \(endpoint.host)")
        XCTAssertEqual(endpoint.path, "/api/json/v1/1/filter.php",
                       "The path should be /api/json/v1/1/filter.php, it was \(endpoint.path)")
        XCTAssertEqual(endpoint.queryItems,  [URLQueryItem(name:"c", value: "Dessert")],
                       "The the query items should be c:Dessert")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert",
            "The  url was \(endpoint.url?.absoluteString ?? "nil")")
    }
    
    func test_with_lookup_random_request_is_valid()  {
        let endpoint = Endpoint.lookupRandom()
        
        XCTAssertEqual(endpoint.host, "www.themealdb.com",
                       "The host should be www.themealdb.com, it was \(endpoint.host)")
        XCTAssertEqual(endpoint.path, "/api/json/v1/1/random.php",
                       "The path should be /api/json/v1/1/random.php, it was \(endpoint.path)")
        XCTAssertNil(endpoint.queryItems,
                       "The the query items should be nil")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://www.themealdb.com/api/json/v1/1/random.php",
            "The url was \(endpoint.url?.absoluteString ?? "nil")")
    }
    
    func test_with_filter_by_area_request_is_valid()  {
        let endpoint = Endpoint.filterByArea(matching: "American")
        
        XCTAssertEqual(endpoint.host, "www.themealdb.com",
                       "The host should be www.themealdb.com, it was \(endpoint.host)")
        XCTAssertEqual(endpoint.path, "/api/json/v1/1/filter.php",
                       "The path should be /api/json/v1/1/filter.php, it was \(endpoint.path)")
        XCTAssertEqual(endpoint.queryItems, [URLQueryItem(name:"a", value: "American")],
                       "The the query items should be a:American")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://www.themealdb.com/api/json/v1/1/filter.php?a=American",
            "The url was \(endpoint.url?.absoluteString ?? "nil")")
    }
    
    func test_with_filter_by_ingredient_request_is_valid()  {
        let endpoint = Endpoint.filterByIngredient(matching:"Chicken")
        
        XCTAssertEqual(endpoint.host, "www.themealdb.com",
                       "The host should be www.themealdb.com, it was \(endpoint.host)")
        XCTAssertEqual(endpoint.path, "/api/json/v1/1/filter.php",
                       "The path should be /api/json/v1/1/filter.php, it was \(endpoint.path)")
        XCTAssertEqual(endpoint.queryItems, [URLQueryItem(name:"i", value:"Chicken")],
                       "The the query items should i:Chicken")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://www.themealdb.com/api/json/v1/1/filter.php?i=Chicken",
            "The url was \(endpoint.url?.absoluteString ?? "nil")")
    }

}
