//
//  RestaurantsViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

@MainActor class RestaurantsViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var isLoading = false
    
    private let fetcher: RestaurantsFetcher
    
    init(fetcher: RestaurantsFetcher = RestaurantsFetcher()) {
        self.fetcher = fetcher
    }
    
    func fetchRestaurants() {
        Task {
            do {
                isLoading = true
                restaurants = try await fetcher.fetchResult(query: "")
            } catch {
                print("Failed to fetch restaurants: \(error)")
            }
            isLoading = false
        }
    }
}
