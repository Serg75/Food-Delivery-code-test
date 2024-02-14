//
//  OpenStatus.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

struct OpenStatus: Decodable {
    let restaurant_id: String
    let is_currently_open: Bool
}
