//
//  CategoryModel.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 6/15/23.
//

import Foundation

struct CategoryModel:Decodable{
    let id: String
    let name: String
    let thumbnail: String
    let description: String
    
    enum CodingKeys: String, CodingKey{
        case id = "idCategory"
        case name = "strCategory"
        case thumbnail = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}

struct CategoryModelResponse:Decodable{
    let categories: [CategoryModel]
}
