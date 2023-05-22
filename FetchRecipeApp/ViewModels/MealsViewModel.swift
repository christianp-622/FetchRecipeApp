//
//  MealsViewModel.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 5/16/23.
//

import Foundation


class MealsViewModel: ObservableObject{
    
    @Published var meals:[MealInstructionsModel] = []
    
    // TODO
    @Published var searchList: [MealInstructionsModel] = []
    
    init(){
        fetchMeals()
    }
    
    // Testing without fetching meals
    init(test:Bool){}
    
    func downloadData(fromURL url:URL, completionHandler: @escaping(_ data: Data?) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode < 300 && response.statusCode >= 200 else {
                    print("Error downloading data")
                    completionHandler(nil)
                    return
            }
            completionHandler(data)
        }.resume()
    }
    
    // Grab the meals from the api
    func fetchMeals() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print("Invalid URL")
            return
        }
        downloadData(fromURL: url) { data in
            if let data = data{
                guard let mealResponse = try? JSONDecoder().decode(apiMealResponse.self, from: data) else {return}
                DispatchQueue.main.async{ [weak self] in
                    // Go through response for each meal and get more data
                    for meal in mealResponse.meals {
                        self?.fetchMealInstructions(mealID:meal.idMeal)
                    }
                }
            }else{
                print("NO DATA RETURNED")
            }
        }
    }
    
    // Grab info for instructions given an id
    func fetchMealInstructions(mealID: String)  {
        guard let url = URL(string:"https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else{
            print("OH NO the id does not map to anything")
            return
        }
        downloadData(fromURL: url){data in
            if let data = data{
                guard let response = try? JSONDecoder().decode(apiMealInstructionRespone.self, from: data)else {return}
                DispatchQueue.main.async {[weak self] in
                    var temp = response.meals[0]
                    temp.strMeal = temp.strMeal.capitalized // Important for sorting
                    temp.filteredIngredients = self?.filterIngredients(meal:temp)
                    temp.formattedInstructions = self?.formatInstructions(meal: temp)
                    self?.meals.append(temp)
                    // I just sorted the list after each addition.
                    self?.sortMealsAtoZ()
                }
            }else{
                print("Could not download instructions data for \(url)")
            }
        }
    }
    
    func sortMealsZtoA(){
        meals = meals.sorted(by:{$0.strMeal > $1.strMeal})
    }
    
   
    func sortMealsAtoZ(){
        meals = meals.sorted(by:{$0.strMeal < $1.strMeal})
    }
    
    // Search option
    func searchMeal(sub:String) {
        searchList = meals.filter({$0.strMeal.hasPrefix(sub)})
    }
    
    // string to list of strings
    func formatInstructions(meal: MealInstructionsModel) -> [String]{
        var lst:[String] = []
        let separators = CharacterSet(charactersIn: "\r\n")
        if let m = meal.strInstructions{
            lst = m.components(separatedBy:separators)
                .filter({!$0.isEmpty})
            
            return lst.isEmpty ? ["Instructions not found"] : lst
        }else{
            // Case for null value
            return ["Instructions not found"]
        }
      
    }
    
    // Lord help me
    func filterIngredients(meal: MealInstructionsModel) -> [String]{
        var resultList:[String] = []
        let m = meal
        
        if let mes = m.strMeasure1,let ing = m.strIngredient1 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure2,let ing = m.strIngredient2 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure3,let ing = m.strIngredient3 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure4,let ing = m.strIngredient4 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure5,let ing = m.strIngredient5 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure6,let ing = m.strIngredient6 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        
        if let mes = m.strMeasure7,let ing = m.strIngredient7 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure8,let ing = m.strIngredient8 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure9,let ing = m.strIngredient9 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure10,let ing = m.strIngredient10 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure11,let ing = m.strIngredient11 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure12,let ing = m.strIngredient12 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure13,let ing = m.strIngredient13 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure14,let ing = m.strIngredient14 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure15,let ing = m.strIngredient15 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure16,let ing = m.strIngredient16 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure17,let ing = m.strIngredient17 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure18,let ing = m.strIngredient18 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure19,let ing = m.strIngredient19 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
        if let mes = m.strMeasure20,let ing = m.strIngredient20 {
            if !mes.trimmingCharacters(in: .whitespaces).isEmpty &&
                !ing.trimmingCharacters(in: .whitespaces).isEmpty {
                resultList.append("\(mes) \(ing)")
            }
        }
            
        
        return resultList.isEmpty ? ["Ingredients not found"] : resultList
         
    }
}

extension MealsViewModel {
    enum MealError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
