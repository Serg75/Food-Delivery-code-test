//
//  RestaurantCardViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-16.
//

import Foundation

@MainActor class RestaurantCardViewModel: ObservableObject, Identifiable {
    let restaurant: Restaurant
    
    @Published var name: String = ""
    @Published var rating: Double = 0.0
    @Published var filtersDescription: String = ""
    @Published var imageUrl: URL?
    @Published var deliveryTime: Int = 0
    
    private let filterFetcher = FilterFetcher()
    private var filters = [Filter]()
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        updateFields()
        Task {
            await fetchFilterDescriptions()
        }
    }
    
    private func updateFields() {
        name = restaurant.name
        rating = restaurant.rating
        filtersDescription = ""
        imageUrl = URL(string: restaurant.imageUrl)
        deliveryTime = restaurant.deliveryTime
    }
    
    private func fetchFilterDescriptions() async {
        let filterIds = restaurant.filters
        
        for filterId in restaurant.filters {
            if let filter = try? await filterFetcher.fetchResult(query: filterId) {
                filters.append(filter)
                updateFilterDescriptions()
            }
        }
    }
    
    private func updateFilterDescriptions() {
        filtersDescription = filters.map{ $0.name }.joined(separator: " • ")
    }
}
