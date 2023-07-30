//
//  CategoriesViewModel.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 6/16/23.
//

import Foundation

class CategoriesViewModel: ObservableObject{
    
    @Published var categories:[CategoryModel] = []
    
    init(){
        fetchCategories()
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
    
    
    // Grab the meals for a given category
    private func fetchCategories() {
        guard let url = Endpoint.retrieveCategories().url else{
            //Handle error
            //self.userError = .invalidEndpoint
            return
        }
        
        
        downloadData(fromURL: url) { data in
            DispatchQueue.main.async { [weak self] in
                if let data = data{
                    guard let catResponse = try? JSONDecoder().decode(CategoryModelResponse.self, from: data) else {return}
                    self?.categories = catResponse.categories
                }else {
                    //Handle error
                    //self?.userError = MealError.failedToDecode(url:url)
                    print("OH NO")
                }
            }
        }
    }
    
    
    
}
