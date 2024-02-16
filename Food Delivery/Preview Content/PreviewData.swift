//
//  PreviewData.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import Foundation
import UIKit

struct PreviewData {
    
    fileprivate static func decodeJSON<T: Decodable>(_ name: String, type: T.Type) -> T {
        let asset = NSDataAsset(name: name, bundle: Bundle.main)
        let data = asset!.data
        let decoder = JSONDecoder()
        return try! decoder.decode(type, from: data)
    }

    static var SomeRestaurant: Restaurant = {
        return Restaurant(apiModel: decodeJSON("restaurant", type: API.Model.Restaurant.self))
    }()
    
}
