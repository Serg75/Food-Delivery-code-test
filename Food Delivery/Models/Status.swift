//
//  Status.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

struct Status {
    let restaurantID: String
    let isOpen: Bool
}

extension Status {
    init(apiModel: API.Model.Status) {
        self.init(
            restaurantID: apiModel.restaurantId,
            isOpen: apiModel.isOpen
        )
    }
}
