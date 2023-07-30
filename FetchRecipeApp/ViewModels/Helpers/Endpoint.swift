//
//  Endpoint.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 5/28/23.
//

import Foundation

// Define Endpoint struct to help with url construction
struct Endpoint{
    let path: String
    let queryItems: [URLQueryItem]?
    
    // Lookup by given id
    static func lookupByID(matching query: String)-> Endpoint {
        return Endpoint(
            path: "/api/json/v1/1/lookup.php",
            queryItems: [URLQueryItem(name: "i", value: query)]
        )
    }
    
    // Filter by category
    static func filterByCategory(matching query: String) -> Endpoint {
        return Endpoint(
            path: "/api/json/v1/1/filter.php",
            queryItems: [URLQueryItem(name:"c", value: query)]
        )
    }
    
    // Lookup random meal
    static func lookupRandom()-> Endpoint {
        return Endpoint(
            path: "/api/json/v1/1/random.php",
            queryItems: nil
        )
    }
    
    // Filter by area
    static func filterByArea(matching query: String) -> Endpoint {
        return Endpoint(
            path: "/api/json/v1/1/filter.php",
            queryItems: [URLQueryItem(name:"a", value: query)]
        )
    }
   
    // Filter by main ingredient
    static func filterByIngredient(matching query: String) -> Endpoint {
        return Endpoint(
            path: "/api/json/v1/1/filter.php",
            queryItems: [URLQueryItem(name:"i", value: query)]
        )
    }
    
    // Return list of categories
    static func retrieveCategories() -> Endpoint {
        return Endpoint(
            path: "/api/json/v1/1/categories.php",
            queryItems:nil
        )
    }
}

// Retrive the URL for an endpoint
extension Endpoint{
    var host: String {"www.themealdb.com"}
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if let items = queryItems {
            components.queryItems = items
        }
        
        return components.url
    }
}
