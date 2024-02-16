//
//  API.Model.Filter.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-15.
//

import Foundation

extension API.Model {
    struct Filter: Decodable {
        let id: String
        let name: String
        let imageUrl: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case imageUrl = "image_url"
        }
    }
}
