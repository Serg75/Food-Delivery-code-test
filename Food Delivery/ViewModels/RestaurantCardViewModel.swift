//
//  RestaurantCardViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-16.
//

import Foundation

@MainActor class RestaurantCardViewModel: ObservableObject, Identifiable {
    @Published var restaurantName: String = ""
    @Published var rating: Double = 0.0
    @Published var filtersDescription: String = ""
    @Published var imageUrl: URL?
    @Published var deliveryTime: Int = 0
    
    let restaurant: Restaurant
    
    private var filterHandler = FilterHandler()
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        updateFields()
        fetchFilterDescriptions()
    }
    
    private func updateFields() {
        restaurantName = restaurant.name
        rating = restaurant.rating
        filtersDescription = ""
        imageUrl = URL(string: restaurant.imageUrl)
        deliveryTime = restaurant.deliveryTime
    }
    
    private func fetchFilterDescriptions() {
        Task {
            await filterHandler.fetchFilterDescriptions(for: restaurant)
            filtersDescription = filterHandler.updateFilterDescriptions()
        }
    }
}
