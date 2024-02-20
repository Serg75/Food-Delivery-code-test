//
//  FilterFetcher.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-15.
//

import Foundation

final class FilterFetcher: FilterQueryFetcher {
    private static let cache = NSCache<NSString, StructWrapper<Filter>>()
    
    func fetchResult(query: String) async throws -> Filter {
        if let cachedFilter = FilterFetcher.cache.object(forKey: query as NSString) {
            return cachedFilter.value
        }
        
        let (data, _) = try await URLSession.shared.data(from: filterURL(query: query))
        let apiFilter = try JSONDecoder().decode(API.Model.Filter.self, from: data)
        let filter = Filter(apiModel: apiFilter)
        
        FilterFetcher.cache.setObject(StructWrapper(filter), forKey: query as NSString)
        
        return filter
    }
    
    private func filterURL(query: String) -> URL {
        return URL(string: "https://food-delivery.umain.io/api/v1/filter/\(query)")!
    }
}

class StructWrapper<T>: NSObject {

    let value: T

    init(_ _struct: T) {
        self.value = _struct
    }
}
