//
//  AppLauncher.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-20.
//

import Foundation

@main
struct AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            Food_DeliveryApp.main()
        } else {
            TestApp.main()
        }
    }
}
