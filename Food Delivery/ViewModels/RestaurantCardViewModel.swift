//
//  RestaurantCardViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-16.
//

import Foundation

@MainActor class RestaurantCardViewModel: ObservableObject, Identifiable {
    @Published var filtersDescription = ""
    let id = UUID()
    let restaurantName: String
    let rating: Double
    let imageUrl: URL?
    let deliveryTime: String
    
    let restaurant: Restaurant
    
    private var filterHandler: FilterHandlerProtocol
    
    init(restaurant: Restaurant, filterHandler: FilterHandlerProtocol = FilterHandler()) {
        self.restaurant = restaurant
        restaurantName = restaurant.name
        rating = restaurant.rating
        imageUrl = URL(string: restaurant.imageUrl)
        deliveryTime = TimeFormatter.formattedTime(minutesTotal: restaurant.deliveryTime)
        self.filterHandler = filterHandler
        fetchFilterDescriptions()
    }
    
    private func fetchFilterDescriptions() {
        Task {
            await filterHandler.fetchFilterDescriptions(for: restaurant)
            filtersDescription = filterHandler.filtersDescription
        }
    }
}
