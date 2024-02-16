//
//  DetailsViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation
import SwiftUI

@MainActor class DetailsViewModel: ObservableObject {
    @Published var restaurantName = ""
    @Published var filtersDescription = ""
    @Published var imageUrl: URL?
    @Published var statusText = "---"
    @Published var statusColor = Color.primary
    @Published var isLoading = false
    
    private let restaurant: Restaurant
    
    private var filterHandler = FilterHandler()
    private let statusFetcher: StatusFetcher
    
    init(restaurant: Restaurant, fetcher: StatusFetcher = StatusFetcher()) {
        self.restaurant = restaurant
        self.statusFetcher = fetcher
        updateFields()
        fetchFilterDescriptions()
        fetchRestaurantStatus()
    }
    
    private func updateFields() {
        restaurantName = restaurant.name
        imageUrl = URL(string: restaurant.imageUrl)
    }
    
    private func fetchFilterDescriptions() {
        Task {
            await filterHandler.fetchFilterDescriptions(for: restaurant)
            filtersDescription = filterHandler.updateFilterDescriptions()
        }
    }

    private func fetchRestaurantStatus() {
        Task {
            do {
                isLoading = true
                let status = try await statusFetcher.fetchResult(query: restaurant.id)
                statusText = status.isOpen ? "Open" : "Closed"
                statusColor = status.isOpen ? Color(hex: 0x2ECC71) : Color(hex: 0xC0392B)
            } catch {
                print("Failed to fetch restaurant detail: \(error)")
            }
            isLoading = false
        }
    }
}
