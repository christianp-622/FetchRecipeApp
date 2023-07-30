//
//  HomeView.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 5/16/23.
//

import SwiftUI


struct MealsView: View {

    @StateObject var mvm: MealsViewModel
    var cat: String

    init(category: String) {
        self.cat = category
        let initialViewModel = MealsViewModel(cat: category)
        _mvm = StateObject(wrappedValue: initialViewModel)
    }
 
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack{
                    Section{
                        ForEach(searchResults, id: \.id){ meal in
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
            }
            .navigationTitle("\(cat) Recipies")
            .searchable(text: $mvm.searchText)
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    toolbarMenu
                }
            }
        }
        
       
    }
    
    // Items that will show up on the screen
    var searchResults: [MealInstructionsModel] {
        return mvm.searchText.isEmpty ? mvm.meals : mvm.meals.filter({$0.name.lowercased().contains(mvm.searchText.lowercased())})
    }
    
    // Toolbar items
    var toolbarMenu: some View {
        Menu {
            Button(action: {mvm.sortMealsAtoZ()}) {
                Label("Sort A to Z", systemImage: "arrow.up")
            }
                
            Button(action: {mvm.sortMealsZtoA()}) {
                Label("Sort Z to A", systemImage: "arrow.down")
            }
            
            Button(action: {mvm.sortMealsZtoA()}) {
                Label("Look ", systemImage: "arrow.down")
            }
        }
        label: {
            Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
        }
    }
}


struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MealsView(category: "Lamb")
               
        }
    }
}
