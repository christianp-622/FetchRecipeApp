//
//  MealInsightsView.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 5/16/23.
//

import SwiftUI

//  View for instructions and ingredients
struct MealInsightsView: View {
    
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
                            text:meal.name,
                            location: meal.area ?? "Area could not be found"),
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
        AsyncImage(url: URL(string:meal.thumb)) { image in
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
               
            ForEach(meal.instructions.indices,id: \.self){i in
                Text("**Step \(i+1)**- \(meal.instructions[i])\n")
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
            
            ForEach(meal.ingredients.indices, id: \.self){ i in
                Text("\(meal.ingredients[i].amount) \(meal.ingredients[i].name)")
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

/*
struct MealInsightsView_Previews: PreviewProvider {
    
        MealInsightsView(meal:)
    }
}
*/

