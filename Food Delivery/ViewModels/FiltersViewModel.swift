//
//  FiltersViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-19.
//

import Foundation

@MainActor class FiltersViewModel: ObservableObject {
    @Published var allFilterVMs: [FilterViewModel] = []
    // used as binding from a view for the logic that determines which filters to display
    @Published var selectedFilterIDs: Set<String> = []
    
    private let filterFetcher: FilterQueryFetcher

    init(filterIDs: [String], filterFetcher: FilterQueryFetcher = FilterFetcher()) {
        self.filterFetcher = filterFetcher
        setFilters(filterIDs: filterIDs)
    }

    func setFilters(filterIDs: [String]) {
        Task {
            await fetchFilters(filterIDs)
        }
    }
    
    private func fetchFilters(_ filterIDs: [String]) async {
        for filterID in filterIDs {
            if let filter = try? await filterFetcher.fetchResult(query: filterID) {
                let filterViewModel = FilterViewModel(filter: filter)
                allFilterVMs.append(filterViewModel)
            }
        }
    }
}
