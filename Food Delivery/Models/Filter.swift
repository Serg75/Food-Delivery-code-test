//
//  Filter.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-15.
//

import Foundation

struct Filter {
    let id: String
    let name: String
    let imageUrl: String
}

extension Filter {
    init(apiModel: API.Model.Filter) {
        self.init(
            id: apiModel.id,
            name: apiModel.name,
            imageUrl: apiModel.imageUrl
        )
    }
}
