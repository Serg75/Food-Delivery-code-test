//
//  Restaurant.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

struct RestaurantList: Decodable {
    let restaurants: [Restaurant]
}

struct Restaurant: Codable, Identifiable {
    let id: String
    let name: String
    let rating: Double
    let filterIds: [String]
    let image_url: String
    let delivery_time_minutes: Int
}
