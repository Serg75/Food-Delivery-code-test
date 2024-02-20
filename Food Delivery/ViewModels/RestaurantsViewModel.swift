//
//  RestaurantsViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

@MainActor class RestaurantsViewModel: ObservableObject {
    // filtered restaurants by selected filters
    @Published var restaurants: [RestaurantCardViewModel] = []
    // stores all filters found while fetching restaurants
    @Published var allFilterIDs: [String] = []
    // set from outside to filter restaurants
    @Published var filterIDsToShow: Set<String> = [] {
        didSet {
            filterRestaurants()
        }
    }
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var allRestaurants: [RestaurantCardViewModel] = []
    private let restaurantsFetcher: RestaurantsQueryFetcher
    
    init(fetcher: RestaurantsQueryFetcher = RestaurantsFetcher()) {
        self.restaurantsFetcher = fetcher
    }
    
    func fetchRestaurants() {
        Task {
            do {
                isLoading = true
                let fetchedRestaurants = try await restaurantsFetcher.fetchResult()
                allRestaurants = fetchedRestaurants.map { RestaurantCardViewModel(restaurant: $0) }
                restaurants = allRestaurants
                allFilterIDs = Array(Set(fetchedRestaurants.flatMap { $0.filters }))
            } catch {
                errorMessage = "Failed to fetch restaurants: \(error)"
            }
            isLoading = false
        }
    }
    
    private func filterRestaurants() {
        if filterIDsToShow.isEmpty {
            restaurants = allRestaurants
            return
        }
        
        restaurants = allRestaurants.filter { !$0.restaurant.filters.intersection(filterIDsToShow).isEmpty }
    }
}
