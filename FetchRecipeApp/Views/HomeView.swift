//
//  HomeView.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 5/16/23.
//

import SwiftUI


struct HomeView: View {
    
    @EnvironmentObject var mealViewModel: MealsViewModel
    @State private var searchText = ""
    
    // Attempted to see how 2 columns looked but did not like it
    let fixedColumns =  [GridItem(.fixed(200)),GridItem(.fixed(200))]
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .edgesIgnoringSafeArea(.all)
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
            .navigationTitle("Dessert Delights")
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
    
    var searchResults: [MealInstructionsModel] {
        return searchText.isEmpty ? mealViewModel.meals : mealViewModel.meals.filter({$0.name.contains(searchText)})
    }
    
    var toolbarMenu: some View {
        Menu {
            Button(action: {mealViewModel.sortMealsAtoZ()}) {
                Label("Sort A to Z", systemImage: "arrow.up")
            }
                
            Button(action: {mealViewModel.sortMealsZtoA()}) {
                Label("Sort Z to A", systemImage: "arrow.down")
            }
        }
        label: {
            Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }.environmentObject(MealsViewModel())
    }
}
