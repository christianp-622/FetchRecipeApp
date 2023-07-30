//
//  CategoriesRow.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 6/16/23.
//

import SwiftUI

struct CategoriesRow: View {
    
    var categoryModels: [CategoryModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Categories")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(categoryModels, id: \.id) { cat in
                        NavigationLink {
                            MealsView(category: cat.name)
                        } label: {
                            CategoryItem(category: cat)
                                .padding(1)
                                
                        }
                    }
                  
                }
            }
            .frame(height:240)
        }
        
        
    }
}

struct CategoriesRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesRow(categoryModels:[CategoryModel(id: "12345", name: "Hello", thumbnail: "https://www.themealdb.com/images/category/beef.png", description: "Temporary description"), CategoryModel(id: "12346", name: "Hello", thumbnail: "https://www.themealdb.com/images/category/beef.png", description: "Temporary description"), CategoryModel(id: "12347", name: "Hello", thumbnail: "https://www.themealdb.com/images/category/beef.png", description: "Temporary description")])
        
    }
}
