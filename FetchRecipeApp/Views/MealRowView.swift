//
//  MealRowView.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 5/16/23.
//

import SwiftUI

// Card views in the home page
struct MealRowView: View {
    
    let meal: MealInstructionsModel
    @State var tapped: Bool = false
    
    var body: some View {
        AsyncImage(url: URL(string:meal.strMealThumb)) { image in
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
        .overlay(imageOverlay(text:meal.strMeal), alignment:.bottom)
        .clipShape(RoundedRectangle(cornerRadius:40, style: .circular))
        .overlay( RoundedRectangle(cornerRadius: 40, style:.circular)
            .stroke(Color("borderColor"), lineWidth: 4))
        .animation(.spring(response: 0.4, dampingFraction: 0.6))
    }
}

// Place on top of Image
struct imageOverlay: View{
    var text: String
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius:0)
                .fill(.black)
                .frame(height:50)
                .opacity(0.7)
                
            Text("**\(text)**")
                .font(.title)
                .scaledToFit()
                .minimumScaleFactor(0.2)
                .lineLimit(1)
                .foregroundColor(.white)
                .padding(.leading)
                .padding(.trailing)
        }
        .cornerRadius(5.0)
    }
}

struct MealRowView_Previews: PreviewProvider {
    static var previews: some View {
        MealRowView(meal:MealInstructionsModel(strMeal: "Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "12345", strArea: "America", strInstructions: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", filteredIngredients: ["ingredient1", "ingredient2", "ingredient3"], formattedInstructions: ["step 1", "step 2", "step3"]))
    }
}
