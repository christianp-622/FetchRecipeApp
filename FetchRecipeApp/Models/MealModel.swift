//
//  MealModel.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 5/16/23.
//

import Foundation

// API response for  the desserts
struct apiMealResponse:Codable {
    struct MealModel: Codable {
        let mealName: String
        let thumb: String
        let id: String
        
        enum CodingKeys: String, CodingKey {
            case mealName = "strMeal"
            case thumb = "strMealThumb"
            case id = "idMeal"
        }
    }
    let meals: [MealModel]
}



// Meal insights Model
struct apiMealInstructionsResponse: Decodable {
    let meals: [MealInstructionsModel]
}

struct MealInstructionsModel: Decodable, Identifiable {
    let id:String
    let name: String
    let thumb: String
    let area: String
    let instructions: [String]
    let ingredients: [Ingredient]
    
    struct Ingredient: Equatable {
        let name:String
        let amount:String
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumb = "strMealThumb"
        case area = "strArea"
        case strInstructions = "strInstructions"
        case ing1 = "strIngredient1"
        case ing2 = "strIngredient2"
        case ing3 = "strIngredient3"
        case ing4 = "strIngredient4"
        case ing5 = "strIngredient5"
        case ing6 = "strIngredient6"
        case ing7 = "strIngredient7"
        case ing8 = "strIngredient8"
        case ing9 = "strIngredient9"
        case ing10 = "strIngredient10"
        case ing11 = "strIngredient11"
        case ing12 = "strIngredient12"
        case ing13 = "strIngredient13"
        case ing14 = "strIngredient14"
        case ing15 = "strIngredient15"
        case ing16 = "strIngredient16"
        case ing17 = "strIngredient17"
        case ing18 = "strIngredient18"
        case ing19 = "strIngredient19"
        case ing20 = "strIngredient20"
        case mes1 = "strMeasure1"
        case mes2 = "strMeasure2"
        case mes3 = "strMeasure3"
        case mes4 = "strMeasure4"
        case mes5 = "strMeasure5"
        case mes6 = "strMeasure6"
        case mes7 = "strMeasure7"
        case mes8 = "strMeasure8"
        case mes9 = "strMeasure9"
        case mes10 = "strMeasure10"
        case mes11 = "strMeasure11"
        case mes12 = "strMeasure12"
        case mes13 = "strMeasure13"
        case mes14 = "strMeasure14"
        case mes15 = "strMeasure15"
        case mes16 = "strMeasure16"
        case mes17 = "strMeasure17"
        case mes18 = "strMeasure18"
        case mes19 = "strMeasure19"
        case mes20 = "strMeasure20"
    }
    
    init(from decoder: Decoder)
        throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(String.self, forKey:.id)
            // Capitalize Name
            name = try values.decode(String.self, forKey:.name).capitalized
            thumb = try values.decode(String.self, forKey: .thumb)
            area = try values.decode(String.self, forKey:.area)
            
            // Format instructions
            var instructionsList:[String] = []
            let separators = CharacterSet(charactersIn: "\r\n")
            if let instructionsString =
                try? values.decode(String.self, forKey:.strInstructions){
                instructionsList = instructionsString.components(separatedBy: separators)
                    .filter({!$0.isEmpty})
                instructions = instructionsList
            }else{
                instructions = ["Instructions not found"]
            }
          
            // Format ingredients
            var list:[Ingredient] = []
            let ingKeys:[CodingKeys] = [
                .ing1, .ing2, .ing3, .ing4, .ing5, .ing6, .ing7,
                .ing8,.ing9, .ing10, .ing11, .ing12,.ing13, .ing14,
                    .ing15, .ing16,.ing17, .ing18, .ing19, .ing20]
            
            let mesKeys:[CodingKeys] = [
                .mes1, .mes2, .mes3, .mes4, .mes5, .mes6, .mes7,
                .mes8,.mes9, .mes10, .mes11, .mes12, .mes13, .mes14,
                    .mes5, .mes16,.mes17, .mes18, .mes19, .mes20]
            
            for i in 0..<20{
                let ingredient = Ingredient(
                    name:(try? values.decode(String.self, forKey: ingKeys[i])) ?? "",
                    amount: (try? values.decode(String.self, forKey: mesKeys[i])) ?? "")
                if !ingredient.name.isEmpty && !ingredient.amount.isEmpty{
                    list.append(ingredient)
                }
            }
            ingredients = list
        }
}


