//
//  RestaurantsFetcher.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

final class RestaurantsFetcher: QueryFetcher {
    func fetchResult(query: String) async throws -> [Restaurant] {
        guard let url = URL(string: "https://food-delivery.umain.io/api/v1/restaurants") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let restaurantList = try JSONDecoder().decode(RestaurantList.self, from: data)
        return restaurantList.restaurants
    }
}
