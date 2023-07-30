//
//  FeaturedMealViewModel.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 6/28/23.
//

import Foundation

class FeaturedMealViewModel: ObservableObject{
    
    @Published var featuredMeal:MealInstructionsModel?
    
    init(){
        fetchRandomMeal()
    }
    
    func downloadData(fromURL url:URL, completionHandler: @escaping(_ data: Data?) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode < 300 && response.statusCode >= 200 else {
                    // Handle Error
                    
                    completionHandler(nil)
                    return
            }
            completionHandler(data)
        }.resume()
    }
    
    // Fetch a random meal
    func fetchRandomMeal() {
        guard let url = Endpoint.lookupRandom().url else {
            //Handle Error
            return
        }
        
        downloadData(fromURL: url){ data in
            DispatchQueue.main.async {[weak self] in
                if let data = data{
                    guard let response = try? JSONDecoder().decode(apiMealInstructionsResponse.self, from: data) else {return}
                    let temp = response.meals[0]
                    self?.featuredMeal = temp
                }
                else{
                    // handle Error
                }
            }
            
        }
    }
    
}
