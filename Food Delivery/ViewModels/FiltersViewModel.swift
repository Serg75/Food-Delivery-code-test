//
//  FiltersViewModel.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-19.
//

import Foundation

@MainActor class FiltersViewModel: ObservableObject {
    @Published var filterVMs: [FilterViewModel] = []
    @Published var filterIDs: Set<String> = []
    
    private var allFilters: [FilterViewModel] = []
    private let filterFetcher = FilterFetcher()

    init(filterIDs: [String]) {
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
                filterVMs.append(filterViewModel)
                allFilters.append(filterViewModel)
            }
        }
    }
}
