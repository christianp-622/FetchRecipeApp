//
//  MealInsightsView.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 5/16/23.
//

import SwiftUI

//  View for instructions and ingredients
struct MealInsightsView: View {
    
    //@EnvironmentObject var mealViewModel: MealsViewModel
    let meal: MealInstructionsModel
    
    var body: some View {
        ZStack{
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            
            VStack{
                imageView
                    .clipShape(RoundedRectangle(cornerRadius:40, style: .circular))
                    .overlay( RoundedRectangle(cornerRadius: 40, style:.circular)
                        .stroke(Color("borderColor"), lineWidth: 4))
                    .padding(.bottom)
                    .padding(.bottom)
                    .padding(.bottom)
                    .overlay(
                        screenOverlay(
                            text:meal.strMeal,
                            location: meal.strArea ?? "Area could not be found"),
                        alignment: .bottom
                    )
                    .edgesIgnoringSafeArea(.all)
                    .frame(minHeight: 250)
                    .layoutPriority(2)
                
               
                ScrollView{
                    ingredientsView
                        .padding()
                    
                    instructionsView
                        .padding()
                }
                    .layoutPriority(3)
                
                Spacer()
            }
            .multilineTextAlignment(.leading)
            .edgesIgnoringSafeArea(.bottom)
          
        }
    }
    
    var imageView: some View{
        AsyncImage(url: URL(string:meal.strMealThumb)) { image in
            image
                .resizable()
                
        } placeholder: {
            ZStack{
                Color(.gray)
                Image("foodIcon")
                    .resizable()
                    .padding()
                
            }
        }
    }
    
    var instructionsView:some View{
        VStack(alignment:.center){
            Text("**Instructions**")
                .font(.largeTitle)
                .underline()
               
            ForEach(meal.formattedInstructions!.indices,id: \.self){i in
                Text("**Step \(i+1)**- \(meal.formattedInstructions![i])\n")
                    .multilineTextAlignment(.center)
                    .padding(.leading)
                    .padding(.trailing)
            }
        }
    }
    
    var ingredientsView:some View{
        VStack(alignment:.center){
            Text("**Ingredients**")
                .font(.largeTitle)
                .underline()
            Text("**You will need:** ")
                .font(.title3)
            
            ForEach(meal.filteredIngredients!, id: \.self){ ing in
                Text(ing)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
}

// Little bubble that you see on the picture
struct screenOverlay: View{
    
    var text: String
    var location: String
    
    var body: some View{
        ZStack {
            Color("bubbleColor")
              
            VStack{
                Text("**\(text)**")
                    .font(.system(size: 60))
                    .scaledToFit()
                    .minimumScaleFactor(0.2)
                    .lineLimit(1)
                    .padding(.leading)
                    .padding(.trailing)
                
                Text("Origin: \(location)")
                    .font(.caption)
            }
            .padding()
        }
        .frame(width:300, height:80)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .overlay( RoundedRectangle(cornerRadius: 40, style:.continuous)
            .stroke(Color.black, lineWidth: 2)
       )
    }
}


struct MealInsightsView_Previews: PreviewProvider {
    static var previews: some View {
        MealInsightsView(meal:MealInstructionsModel(strMeal: "Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "12345", strArea: "America", strInstructions: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", filteredIngredients: ["ingredient1", "ingredient2", "ingredient3"], formattedInstructions: ["step 1", "step 2", "step3"]))
    }
}
