//
//  RestaurantsViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

@MainActor class RestaurantsViewModel: ObservableObject {
    @Published var restaurants: [RestaurantCardViewModel] = []
    @Published var isLoading = false
    
    private let fetcher: RestaurantsFetcher
    
    init(fetcher: RestaurantsFetcher = RestaurantsFetcher()) {
        self.fetcher = fetcher
    }
    
    func fetchRestaurants() {
        Task {
            do {
                isLoading = true
                let fetchedRestaurants = try await fetcher.fetchResult(query: "")
                restaurants = fetchedRestaurants.map { RestaurantCardViewModel(restaurant: $0) }
            } catch {
                print("Failed to fetch restaurants: \(error)")
            }
            isLoading = false
        }
    }
}
