//
//  MealRowView.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 5/16/23.
//

import SwiftUI

// Card views in the home page
struct MealRowView: View {
    let thumb: String
    let name: String
    
    var body: some View {
        AsyncImage(url: URL(string:thumb)) { image in
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
        .overlay(imageOverlay(text:name), alignment:.bottom)
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
        MealRowView(thumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", name: "Cake")
    }
}

