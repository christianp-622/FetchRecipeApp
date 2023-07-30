//
//  CategoryPickerOption.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 6/14/23.
//

import Foundation

// Conform it to hashable for foreach
struct MenuPickerOption: Identifiable, Hashable {
    let id = UUID().uuidString
    let option: String
}

extension MenuPickerOption {
    static let testSingleArea: MenuPickerOption = MenuPickerOption(option: "Hello Hi")
    static let testAllAreas: [MenuPickerOption] = [
        MenuPickerOption(option: "American"),
        MenuPickerOption(option: "British"),
        MenuPickerOption(option: "Canadian"),
        MenuPickerOption(option: "Chinese"),
        MenuPickerOption(option: "Croatian"),
        MenuPickerOption(option: "Dutch"),
        MenuPickerOption(option: "Egyptian"),
        MenuPickerOption(option: "Filipino"),
        MenuPickerOption(option: "French"),
        MenuPickerOption(option: "Greek"),
        MenuPickerOption(option: "Indian"),
        MenuPickerOption(option: "Irish")
    ]
    
}
