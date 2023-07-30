//
//  FeaturedMeal.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 6/18/23.
//

import SwiftUI

struct FeaturedMeal: View {
    
    var meal: MealInstructionsModel
   
    var body: some View {
        VStack{
            Text("Featured Meal")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            Text("\(meal.name)")
                .font(.caption)
          
            AsyncImage(url: URL(string: meal.thumb)) { image in
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
            .aspectRatio(contentMode: .fit)
            .clipShape(
                RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 1))
            .overlay(overlay, alignment: .bottomTrailing)
        }
    }
    
    var overlay: some View {
        VStack(alignment:.trailing){
            NavigationLink(destination:MealInsightsView(meal:meal)){
                Text("View Insights")
                    .font(.headline)
                    .foregroundColor(.blue.opacity(0.5))
                    .padding()
            }
            .frame(height:40)
            .background(Color.white.opacity(0.9))
            .mask(RoundedRectangle(cornerRadius: 30))
            .shadow(radius:10)
            
        }
        .padding()
    }
}

//struct FeaturedMeal_Previews: PreviewProvider {
//    static var previews: some View {
//        FeaturedMeal(thumb: "https://www.themealdb.com/images/media/meals/rwuyqx1511383174.jpg")
//    }
//}
