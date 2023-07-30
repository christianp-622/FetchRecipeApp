//
//  HomeView2.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 6/13/23.
//

import SwiftUI

struct HomeView2: View {
    
    @EnvironmentObject var mealViewModel: MealsViewModel
        
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                MenuPickerView(selectedOption: .constant(nil) , placeholder: "Choose an area", options: MenuPickerOption.testAllAreas)
                ScrollView{
                    VStack{
                        ForEach(mealViewModel.meals, id: \.id){ meal in
                            NavigationLink(destination:
                                            MealInsightsView(
                                                meal:meal)) {
                                MealRowView(thumb: meal.thumb, name: meal.name)
                                    .shadow(radius:10, x:1, y:4)
                                    .padding(20)
                            }
                        }
                    
                    }
                }
                .navigationTitle("Recipe Finder")
             
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        toolbarMenu
                    }
                    ToolbarItem(placement:.navigationBarLeading){
                        Button(action: {
                            //TODO. Seach feature
                           
                        }) {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                    }
            }
            }
        }
    }
    
    
    // Toolbar items
    var toolbarMenu: some View {
        Menu {
            Button(action: {mealViewModel.sortMealsAtoZ()}) {
                Label("Sort A to Z", systemImage: "arrow.up")
            }
                
            Button(action: {mealViewModel.sortMealsZtoA()}) {
                Label("Sort Z to A", systemImage: "arrow.down")
            }
            
            Button(action: {mealViewModel.sortMealsZtoA()}) {
                Label("Look ", systemImage: "arrow.down")
            }
        }
        label: {
            Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
        }
    }
}


struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView2()
        }.environmentObject(MealsViewModel(cat: "Lamb"))
    }
}

