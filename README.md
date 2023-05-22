# FetchRecipeApp

Dessert Delights (FetchRecipeApp) is a simple iOS application allowing a user to view desserts and instructions/ingredients to make them!  


## Table of Contents

1. [Project Overview](#project-overview)
2. [Files](#files)
3. [Demo](#demo)
4. [Acknowledgment](#acknowledgment)
5. [Roadmap](#roadmap)


## Project Overview

The goal of this project was to allow a user to view a dessert and corresponding instructions to make it. The data used was hosted by TheMealDB, and the frontend of this application was implemented using the SwiftUI framework. 

## Files

- **/FetchRecipeApp**: Contains the source code files of the iOS app.

  - `FetchRecipeAppApp.swift`: Main app file. Initializes all environment objects and invokes the launch screen.

  - **/Models**: Contains model file
    - `MealModel.swift`: Defines the data models and their operations. For this API I needed to create multiple models for each endpoint.

  - **/ViewModels**: Contains the file that defines the view model.

    -  `MealsViewModel.swift`: Invokes a network call for each endpoint and hosts the data for all the desserts. Additionally takes care of formatting and filtering the data retrieved.

  - **/Views**: Contains all the views for the application
    - **/LaunchScreen**: Contains files for the launch screen
      - `LaunchScreenView.swift`: View that animates the application logo in an "ease-in-out-and-back-in" manner.

      - `LaunchScreenManager.swift`": Defines enum for launch screen phase as well as function to dismiss the launch screen animation.

    - `HomeView.swift`: Defines the view for the home page. Places each individual dessert in a mealRowView that will navigate you to the ingredients and instructions when tapped. Additionally has a filter button at the top.

    - `MealRowView.swift`: Defines the view for a row in the home page.

    - `MealInsightsView.swift`: Defines the view for the instructions and ingredients of a given dessert. Also contains the origin of the meal.
    
- **/FetchRecipeAppTests**: Contains unit tests for the ViewModel class
  - `FetchRecipeAppTests.swift`: Contains unit test for network calls. Can be improved with dependency injection. Tests the ViewModel methods as well
- **/FetchRecipeAppUITests**: Contains unit tests for UI. This portion is not completed and does not contain anything significant.
 

## Demo
![alt text](https://github.com/christianp-622/FetchRecipeApp/blob/main/FetchRecipeApp/Demo/screenshotHome.png?raw=true)
![alt text](https://github.com/christianp-622/FetchRecipeApp/blob/main/FetchRecipeApp/Demo/screenshotInsights.png?raw=true)

## Acknowledgment
I would like to thank Nick from the Swiftful Thinking Youtube Channel and Tunde from the Tundsdev Youtube Channel. They taught me how to properly perform a network request via URLSession and  how to write asynchronous unit tests. 

## Roadmap

For future iterations of this project, I want to implement a couple of things:
  - Search feature and corresponding view that will take text from a text field and filter the list of meals based on that.
  - Divide the home page in to different sections that include other categories besides desserts.
  - Add a favorites section! 
  - UI Tests for the UI and all the views. Right now I do not know how to make them so I need more time to learn how to do that.
  - Unit tests with dependency injection because my tests currently test the network itself (learned that I am not supposed to do that).
  - Handle errors in a more sophisticated manner with a custom error class in the ViewModel. 


