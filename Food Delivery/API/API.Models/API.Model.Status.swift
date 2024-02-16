//
//  API.Model.Status.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-16.
//

import Foundation

extension API.Model {
    struct Status: Decodable {
        let restaurantId: String
        let isOpen: Bool

        enum CodingKeys: String, CodingKey {
            case restaurantId = "restaurant_id"
            case isOpen = "is_currently_open"
        }
    }
}
