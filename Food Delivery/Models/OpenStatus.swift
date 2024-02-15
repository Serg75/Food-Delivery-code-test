//
//  OpenStatus.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

struct OpenStatus: Decodable {
    let restaurantId: String
    let isOpen: Bool
    
    enum CodingKeys: String, CodingKey {
        case restaurantId = "restaurant_id"
        case isOpen = "is_currently_open"
    }
}
