//
//  Status.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

struct Status {
    let restaurantId: String
    let isOpen: Bool
}

extension Status {
    init(apiModel: API.Model.Status) {
        self.init(
            restaurantId: apiModel.restaurantId,
            isOpen: apiModel.isOpen
        )
    }
}
