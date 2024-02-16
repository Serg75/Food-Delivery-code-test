//
//  FilterHandler.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-17.
//

import Foundation

class FilterHandler {
    private let filterFetcher = FilterFetcher()
    private var filters = [Filter]()
    
    func fetchFilterDescriptions(for restaurant: Restaurant) async {
        for filterId in restaurant.filters {
            if let filter = try? await filterFetcher.fetchResult(query: filterId) {
                filters.append(filter)
            }
        }
    }
    
    func updateFilterDescriptions() -> String {
        return filters.map{ $0.name }.joined(separator: " • ")
    }
}
