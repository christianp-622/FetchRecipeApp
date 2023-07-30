//
//  HomeView3.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 6/18/23.
//

import SwiftUI

struct HomeView3: View {
    
    @EnvironmentObject var cvm: CategoriesViewModel
    @EnvironmentObject var fmvm: FeaturedMealViewModel
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack{
                    if let featuredMeal = fmvm.featuredMeal {
                        
                       FeaturedMeal(meal: featuredMeal)
                            .id(featuredMeal.id)
                            .overlay(
                                Button(action: {fmvm.fetchRandomMeal()}){
                                    Image(systemName:"arrow.clockwise")
                                        .frame(width:40, height:40)
                                        .background(Color.white.opacity(0.9))
                                        .mask(RoundedRectangle(cornerRadius: 30))
                                        .shadow(radius:10)
                                        .padding(20)
                                    
                            }, alignment: .bottomLeading)
                           
                    }
                    
                    CategoriesRow(categoryModels: cvm.categories)
                      
                }
                .navigationTitle("Recipe Delights")
            }
        }
    }
}

struct HomeView3_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView3()
        }
        .environmentObject(FeaturedMealViewModel())
        .environmentObject(CategoriesViewModel())
        
    }
}
