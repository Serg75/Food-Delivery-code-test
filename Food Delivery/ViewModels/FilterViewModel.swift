//
//  FilterViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-19.
//

import Foundation

@MainActor class FilterViewModel: ObservableObject, Identifiable {
    let filterLabel: String
    let imageUrl: URL?
    
    init(filter: Filter) {
        self.filterLabel = filter.name
        self.imageUrl = URL(string: filter.imageUrl)
    }
}
