//
//  DetailsViewModelTests.swift
//  Food DeliveryTests
//
//  Created by Sergey Slobodenyuk on 2024-02-20.
//

import XCTest
import SwiftUI
@testable import Food_Delivery

final class DetailsViewModelTests: XCTestCase {
    
    class MockStatusFetcher: StatusQueryFetcher {
        private let result: Status
        private let shouldThrow: Bool
        
        init(result: Status, shouldThrow: Bool = false) {
            self.result = result
            self.shouldThrow = shouldThrow
        }
        
        func fetchResult(query: String) async throws -> Status {
            // Simulate async behavior
            try? await Task.sleep(nanoseconds: 1_000_000_000) // Sleep for 1 second
            if shouldThrow {
                throw URLError(.unknown)
            }
            return result
        }
    }
    
    class MockFilterHandler: FilterHandlerProtocol {
        var filtersDescription = ""
        
        private let storedValue: String
        
        init(filtersDescription: String) {
            self.storedValue = filtersDescription
        }
        
        func fetchFilterDescriptions(for restaurant: Restaurant) async {
            // Simulate async behavior
            try! await Task.sleep(nanoseconds: 1_000_000_000) // Sleep for 1 second
            self.filtersDescription = storedValue
        }
    }
    
    @MainActor
    func testViewModelInitialization() {
        // Given
        let restaurant = Restaurant(
            id: "1",
            name: "Test Restaurant",
            rating: 4.5,
            filters: [],
            imageUrl: "https://example.com/image.jpg",
            deliveryTime: 30)
        
        // When
        let viewModel = DetailsViewModel(restaurant: restaurant)
        
        // Then
        XCTAssertEqual(viewModel.restaurantName, "Test Restaurant")
        XCTAssertEqual(viewModel.imageUrl, URL(string: "https://example.com/image.jpg"))
        XCTAssertEqual(viewModel.statusText, "---")
        XCTAssertEqual(viewModel.statusColor, Color.primary)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor
    func testFetchFilterDescriptionsSuccess() async {
        // Given
        let restaurant = Restaurant(
            id: "1",
            name: "Test Restaurant",
            rating: 4.5,
            filters: [],
            imageUrl: "https://example.com/image.jpg",
            deliveryTime: 30)
        
        let viewModel = DetailsViewModel(
            restaurant: restaurant,
            filterHandler: MockFilterHandler(filtersDescription: "Mock filters description"))
        
        // Set expectation for changing $filtersDescription value
        let exp = expectValue(of: viewModel.$filtersDescription,
                              equality: { !$0.isEmpty })

        // When
        viewModel.exposedFetchFilterDescriptions()
        
        // Wait for expectation
        await fulfillment(of: [exp.expectation], timeout: 2)

        // Then
        XCTAssertEqual(viewModel.filtersDescription, "Mock filters description")
    }
    
    @MainActor
    func testFetchRestaurantStatusSuccess() async {
        // Given
        let restaurant = Restaurant(
            id: "1",
            name: "Test Restaurant",
            rating: 4.5,
            filters: [],
            imageUrl: "https://example.com/image.jpg",
            deliveryTime: 30)
        
        let viewModel = DetailsViewModel(
            restaurant: restaurant,
            fetcher: MockStatusFetcher(result: Status(restaurantID: restaurant.id, isOpen: true)))
        
        // Set expectation for changing $isLoading value
        let exp = expectValue(of: viewModel.$isLoading,
                              equality: { !$0 })

        // When
        viewModel.exposedFetchRestaurantStatus()
        
        // Wait for expectation
        await fulfillment(of: [exp.expectation], timeout: 2)

        // Then
        XCTAssertEqual(viewModel.statusText, "Open")
        XCTAssertEqual(viewModel.statusColor, Color(hex: 0x2ECC71))
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor
    func testFetchRestaurantStatusFailure() async {
        // Given
        let restaurant = Restaurant(
            id: "1",
            name: "Test Restaurant",
            rating: 4.5,
            filters: [],
            imageUrl: "https://example.com/image.jpg",
            deliveryTime: 30)
        
        let viewModel = DetailsViewModel(
            restaurant: restaurant,
            fetcher: MockStatusFetcher(
                result: Status(restaurantID: "1", isOpen: true),
                shouldThrow: true))
        
        // Set expectation for changing $isLoading value
        let exp = expectValue(of: viewModel.$isLoading,
                              equality: { !$0 })

        // When
        viewModel.exposedFetchRestaurantStatus()
        
        // Wait for expectation
        await fulfillment(of: [exp.expectation], timeout: 2)

        // Then
        XCTAssertEqual(viewModel.statusText, "---")
        XCTAssertEqual(viewModel.statusColor, Color.primary)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
