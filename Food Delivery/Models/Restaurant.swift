//
//  Restaurant.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

struct Restaurant: Identifiable {
    let id: String
    let name: String
    let rating: Double
    let filters: Set<String>
    let imageUrl: String
    let deliveryTime: Int
}

extension Restaurant {
    init(apiModel: API.Model.Restaurant) {
        self.init(
            id: apiModel.id,
            name: apiModel.name,
            rating: apiModel.rating,
            filters: Set(apiModel.filters),
            imageUrl: apiModel.imageUrl,
            deliveryTime: apiModel.deliveryTime
        )
    }
}
