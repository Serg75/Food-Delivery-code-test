//
//  API.Model.Restaurant.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-15.
//

import Foundation

extension API.Model {
    struct RestaurantList: Decodable {
        let restaurants: [Restaurant]
    }

    struct Restaurant: Decodable {
        let id: String
        let name: String
        let rating: Double
        let filters: [String]
        let imageUrl: String
        let deliveryTime: Int
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case rating
            case filters = "filterIds"
            case imageUrl = "image_url"
            case deliveryTime = "delivery_time_minutes"
        }
    }
}
