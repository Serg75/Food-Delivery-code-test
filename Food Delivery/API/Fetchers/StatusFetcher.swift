//
//  StatusFetcher.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

final class StatusFetcher: StatusQueryFetcher {
    func fetchResult(query: String) async throws -> Status {
        guard let url = URL(string: "https://food-delivery.umain.io/api/v1/open/\(query)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let apiStatus = try JSONDecoder().decode(API.Model.Status.self, from: data)
        
        return Status(apiModel: apiStatus)
    }
}
