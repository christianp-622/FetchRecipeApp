//
//  CategoryItem.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 6/17/23.
//

import SwiftUI

struct CategoryItem: View {
    
    var category:CategoryModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack{
                Color("pickerRowColor")
                AsyncImage(url: URL(string:category.thumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    ZStack{
                        Color(.gray)
                        Image("foodIcon")
                            .resizable()
                            .padding()
                    }
                }
                
            }
            .frame(width:220, height:220)
            .clipShape(RoundedRectangle(cornerRadius:40, style: .circular))
            .overlay( RoundedRectangle(cornerRadius: 40, style:.circular)
                .stroke(Color.gray, lineWidth: 2))
            .animation(.spring(response: 0.4, dampingFraction: 0.6))
            
            Text(category.name)
                .foregroundColor(.primary)
                .font(.caption)
            
        }
        .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(category: CategoryModel(id: "12345", name: "Hello", thumbnail: "https://www.themealdb.com/images/category/beef.png", description: "Temporary description"))
        
    }
}
