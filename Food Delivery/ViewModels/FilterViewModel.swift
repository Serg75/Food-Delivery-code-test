//
//  FilterViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-19.
//

import Foundation

@MainActor class FilterViewModel: ObservableObject, Identifiable {
    let filterID: String
    let filterLabel: String
    let imageUrl: URL?
    
    init(filter: Filter) {
        self.filterID = filter.id
        self.filterLabel = filter.name
        self.imageUrl = URL(string: filter.imageUrl)
    }
}
