//
//  MealError.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 5/28/23.
//

import Foundation

// Handle Error Cases
extension MealsViewModel {
    enum MealError: LocalizedError {
        case invalidEndpoint
        case failedToDownload
        case failedToDecode(url: URL)
        case failedToDecodeInstructions(url:URL)
        
        var errorDescription: String? {
            switch self {
            case .invalidEndpoint:
                return "Invalid url"
            case .failedToDecode(let url):
                return "Failed to decode response from \(url.description)"
            case .failedToDownload:
                return "Failed to download data"
            case .failedToDecodeInstructions(let url):
                return "Failed to decode instruction response from \(url.description)"
            }
        }
    }
}
