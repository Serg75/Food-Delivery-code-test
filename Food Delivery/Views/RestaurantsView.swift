//
//  RestaurantsView.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-19.
//

import SwiftUI

struct RestaurantsView: View {
    @StateObject private var viewModel: RestaurantsViewModel
    @State private var selectedRestaurant: RestaurantCardViewModel?
    
    let size: CGSize
    
    init(viewModel: RestaurantsViewModel, size: CGSize) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.size = size
    }
    
    var body: some View {
        List(viewModel.restaurants) { restaurantVM in
            RestaurantCard(viewModel: restaurantVM, size: size)
                .onTapGesture {
                    selectedRestaurant = restaurantVM
                }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("Restaurants")
        .overlay(ActivityIndicator(isAnimating: $viewModel.isLoading))
        .sheet(item: $selectedRestaurant) { restaurantVM in
            RestaurantDetailView(viewModel: DetailsViewModel(restaurant: restaurantVM.restaurant))
        }
        .onAppear {
            viewModel.fetchRestaurants()
        }
    }
}

#Preview {
    RestaurantsView(
        viewModel:
            RestaurantsViewModel(),
        size:
            // iPhone 15 screen size
        CGSize(width: 393, height: 852)
    )
}
