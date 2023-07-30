//
//  MealsViewModel.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 5/16/23.
//

import Foundation



class MealsViewModel: ObservableObject{
    
    @Published var meals:[MealInstructionsModel] = []
    
    @Published var searchText: String = ""
    @Published var userError:MealError?
    
    init(cat: String){
        fetchMealsByCategory(category: cat)
       
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
                    // Handle Error
                    self.userError = MealError.failedToDownload
                    completionHandler(nil)
                    return
            }
            completionHandler(data)
        }.resume()
    }
    
    // Grab the meals for a given category
   func fetchMealsByCategory(category: String) {
        guard let url = Endpoint.filterByCategory(matching: category).url else{
            self.userError = .invalidEndpoint
            return
        }
        
        downloadData(fromURL: url) { data in
            DispatchQueue.main.async { [weak self] in
                if let data = data{
                    guard let mealResponse = try? JSONDecoder().decode(apiMealResponse.self, from: data) else {return}
                    var count = 0
                    for meal in mealResponse.meals {
                        if count > 10 {
                            break
                        }
                        self?.fetchMealInstructions(.lookupByID(matching:meal.id))
                        count += 1
                    }
                }else {
                    self?.userError = MealError.failedToDecode(url:url)
                }
            }
        }
    }
    
    
    // Grab info for instructions given an id
    private func fetchMealInstructions(_ endpoint: Endpoint)  {
        guard let url = endpoint.url else{
            self.userError = .invalidEndpoint
            return
        }
        
        downloadData(fromURL: url){data in
            DispatchQueue.main.async {[weak self] in
                if let data = data{
                    guard let response = try? JSONDecoder().decode(apiMealInstructionsResponse.self, from: data) else {return}
                    let temp = response.meals[0]
                    self?.meals.append(temp)
                    print(temp.name)
                    self?.sortMealsAtoZ() // I sorted the list after each addition
                }
                else{
                    self?.userError = MealError.failedToDecodeInstructions(url:url)
                }
            }
        }
    }
    
    func sortMealsZtoA(){
        meals = meals.sorted(by:{$0.name > $1.name})
    }
    
    func sortMealsAtoZ(){
        meals = meals.sorted(by:{$0.name < $1.name})
    }
    
    
}
