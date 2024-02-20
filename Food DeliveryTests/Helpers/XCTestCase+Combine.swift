//
//  XCTestCase+Combine.swift
//  Food DeliveryTests
//
//  Created by Sergey Slobodenyuk on 2024-02-20.
//

import Foundation

import Combine
import XCTest

extension XCTestCase {

    // Used as a result in `expectValue` function.
    typealias CompletionResult = (expectation: XCTestExpectation,
                                  cancellable: AnyCancellable)
    
    
    /// Expectation for @Published properties.
    /// - Parameters:
    ///   - publisher: The property to expecting
    ///   - isInverted: True if we expect that property should not be changed
    ///   - equality: Closure that returns true when property has expected value
    /// - Returns: Tuple of created expectation and cancelable
    func expectValue<T: Publisher>(of publisher: T,
                                   isInverted: Bool = false,
                                   equality: @escaping (T.Output) -> Bool) -> CompletionResult where T.Failure == Never {
        
        let exp = expectation(description: "Correct values of " + String(describing: publisher))
        exp.isInverted = isInverted
        let cancellable = publisher
            .debounce(for: 0.1, scheduler: DispatchQueue.main)
            .sink(receiveValue: { value in
                if equality(value) {
                    exp.fulfill()
                }
            })
        return (exp, cancellable)
    }
}
