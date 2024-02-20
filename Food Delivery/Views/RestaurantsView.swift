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
    
    
    init(viewModel: RestaurantsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geometry in
            List(viewModel.restaurants) { restaurantVM in
                RestaurantCard(viewModel: restaurantVM, size: geometry.size)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color(.systemGray6))
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
}

#Preview {
    RestaurantsView(
        viewModel:
            RestaurantsViewModel(fetcher: PreviewData.RestaurantsFetcher())
    )
}
