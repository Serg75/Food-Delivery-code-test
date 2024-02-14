//
//  QueryFetcher.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation

protocol QueryFetcher {
    associatedtype Result
    
    func fetchResult(query: String) async throws -> Result
}
