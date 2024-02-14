//
//  StatusFetcher.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

final class StatusFetcher: QueryFetcher {
    func fetchResult(query: String) async throws -> OpenStatus {
        guard let url = URL(string: "https://food-delivery.umain.io/api/v1/open/\(query)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(OpenStatus.self, from: data)
    }
}
