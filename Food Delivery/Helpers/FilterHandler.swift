//
//  FilterHandler.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-17.
//

import Foundation

protocol FilterHandlerProtocol {
    var filtersDescription: String { get }
    func fetchFilterDescriptions(for restaurant: Restaurant) async
}

class FilterHandler: FilterHandlerProtocol {
    private let filterFetcher: FilterQueryFetcher
    private var filters = [Filter]()
    
    init(filterFetcher: FilterQueryFetcher = FilterFetcher()) {
        self.filterFetcher = filterFetcher
    }
    
    func fetchFilterDescriptions(for restaurant: Restaurant) async {
        for filterID in restaurant.filters {
            if let filter = try? await filterFetcher.fetchResult(query: filterID) {
                filters.append(filter)
            }
        }
    }
    
    var filtersDescription: String {
        return filters.map{ $0.name }.joined(separator: " • ")
    }
}
