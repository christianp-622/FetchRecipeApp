//
//  FetchRecipeAppApp.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 5/16/23.
//

import SwiftUI

@main
struct FetchRecipeAppApp: App {
    @StateObject var featuredMealViewModel: FeaturedMealViewModel = FeaturedMealViewModel()
    @StateObject var catsViewModel: CategoriesViewModel = CategoriesViewModel()
    @StateObject var launchScreenManager = LaunchScreenManager()

    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationView{
                    HomeView3()
                }
                .environmentObject(featuredMealViewModel)
                .environmentObject(catsViewModel)
              
                
                
                if launchScreenManager.state != .completed{
                    LaunchScreenView()
                        .onAppear{
                            DispatchQueue.main
                                .asyncAfter(deadline:.now() + 5){
                                    launchScreenManager.dismiss()
                                }
                        }
                }
            }
            .environmentObject(launchScreenManager)
            
        }
    }
}
