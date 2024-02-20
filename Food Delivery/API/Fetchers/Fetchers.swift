//
//  Fetchers.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation


protocol RestaurantsQueryFetcher {
    func fetchResult() async throws -> [Restaurant]
}

protocol FilterQueryFetcher {
    func fetchResult(query: String) async throws -> Filter
}

protocol StatusQueryFetcher {
    func fetchResult(query: String) async throws -> Status
}
