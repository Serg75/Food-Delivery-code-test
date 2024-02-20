//
//  DetailsViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation
import SwiftUI

@MainActor class DetailsViewModel: ObservableObject {
    @Published var filtersDescription = ""
    @Published var imageUrl: URL?
    @Published var statusText = "---"
    @Published var statusColor = Color.primary
    @Published var isLoading = false
    let restaurantName: String
    
    private let restaurant: Restaurant
    
    private var filterHandler: FilterHandlerProtocol
    private let statusFetcher: StatusQueryFetcher
    
    init(restaurant: Restaurant,
         fetcher: StatusQueryFetcher = StatusFetcher(),
         filterHandler: FilterHandlerProtocol = FilterHandler()) {
        
        self.restaurant = restaurant
        self.statusFetcher = fetcher
        self.restaurantName = restaurant.name
        self.imageUrl = URL(string: restaurant.imageUrl)
        self.filterHandler = filterHandler
        fetchFilterDescriptions()
        fetchRestaurantStatus()
    }
    
    private func fetchFilterDescriptions() {
        Task {
            await filterHandler.fetchFilterDescriptions(for: restaurant)
            filtersDescription = filterHandler.filtersDescription
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
