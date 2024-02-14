//
//  DetailsViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

@MainActor class DetailsViewModel: ObservableObject {
    @Published var restaurantStatus: OpenStatus?
    @Published var isLoading = false
    
    let restaurant: Restaurant
    
    private let fetcher: StatusFetcher
    
    init(restaurant: Restaurant, fetcher: StatusFetcher = StatusFetcher()) {
        self.restaurant = restaurant
        self.fetcher = fetcher
    }
    
    func fetchRestaurantStatus() {
        Task {
            do {
                isLoading = true
                restaurantStatus = try await fetcher.fetchResult(query: restaurant.id)
            } catch {
                print("Failed to fetch restaurant detail: \(error)")
            }
            isLoading = false
        }
    }
}
