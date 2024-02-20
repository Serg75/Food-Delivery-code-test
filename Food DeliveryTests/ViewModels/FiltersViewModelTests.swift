//
//  FiltersViewModelTests.swift
//  Food DeliveryTests
//
//  Created by Sergey Slobodenyuk on 2024-02-20.
//

import XCTest
@testable import Food_Delivery

final class FiltersViewModelTests: XCTestCase {
    
    class MockFilterFetcher: FilterQueryFetcher {
        var result: (String) throws -> Filter
        
        init(result: @escaping (String) throws -> Filter) {
            self.result = result
        }
        
        func fetchResult(query: String) async throws -> Filter {
            // Simulate async behavior
            try? await Task.sleep(nanoseconds: 1_000_000_000) // Sleep for 1 second
            return try result(query)
        }
    }
    
    @MainActor
    func testViewModelInitialization() {
        // Given
        let filterIDs = ["1", "2", "3"]
        
        // When
        let viewModel = FiltersViewModel(filterIDs: filterIDs)
        
        // Then
        XCTAssertTrue(viewModel.allFilterVMs.isEmpty)
        XCTAssertTrue(viewModel.selectedFilterIDs.isEmpty)
    }
    
    @MainActor
    func testSetFiltersSuccess() async {
        // Given
        let filterIDs = ["1", "2", "3"]
        let filterFetcher = MockFilterFetcher { id in
            Filter(id: id,
                   name: "Test Filter \(id)",
                   imageUrl: "https://example.com/image\(id).jpg")
        }
        
        let viewModel = FiltersViewModel(filterIDs: [], filterFetcher: filterFetcher)
        
        // Set expectation for changing $allFilterVMs value
        let exp = expectValue(of: viewModel.$allFilterVMs,
                              equality: { $0.count == filterIDs.count })

        // When
        viewModel.setFilters(filterIDs: filterIDs)
        
        // Wait for expectation
        await fulfillment(of: [exp.expectation], timeout: 10)

        // Then
        XCTAssertEqual(viewModel.allFilterVMs.count, filterIDs.count)
        for (index, filterID) in filterIDs.enumerated() {
            XCTAssertEqual(viewModel.allFilterVMs[index].filterID, filterID)
            XCTAssertEqual(viewModel.allFilterVMs[index].filterLabel, "Test Filter \(filterID)")
            XCTAssertEqual(viewModel.allFilterVMs[index].imageUrl, URL(string: "https://example.com/image\(filterID).jpg"))
        }
    }
    
    @MainActor
    func testSetFiltersFailure() async {
        // Given
        let filterIDs = ["1", "2", "3"]
        let filterFetcher = MockFilterFetcher { id in
            if id == "2" {
                throw URLError(.unknown)
            }
            return Filter(id: id,
                          name: "Test Filter \(id)",
                          imageUrl: "https://example.com/image\(id).jpg")
        }

        // Setting shouldThrow to true to simulate a failure
        let viewModel = FiltersViewModel(filterIDs: [], filterFetcher: filterFetcher)
        
        // Set expectation for changing $allFilterVMs value (only 2 successfully fetched)
        let exp = expectValue(of: viewModel.$allFilterVMs,
                              equality: { $0.count == 2 })

        // When
        viewModel.setFilters(filterIDs: filterIDs)
        
        // Wait for expectation
        await fulfillment(of: [exp.expectation], timeout: 10)

        // Then
        XCTAssertEqual(viewModel.allFilterVMs.count, 2)

        XCTAssertEqual(viewModel.allFilterVMs[0].filterID, "1")
        XCTAssertEqual(viewModel.allFilterVMs[0].filterLabel, "Test Filter 1")
        XCTAssertEqual(viewModel.allFilterVMs[0].imageUrl, URL(string: "https://example.com/image1.jpg"))

        XCTAssertEqual(viewModel.allFilterVMs[1].filterID, "3")
        XCTAssertEqual(viewModel.allFilterVMs[1].filterLabel, "Test Filter 3")
        XCTAssertEqual(viewModel.allFilterVMs[1].imageUrl, URL(string: "https://example.com/image3.jpg"))
    }
}
