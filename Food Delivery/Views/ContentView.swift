//
//  ContentView.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RestaurantsViewModel()
    @State private var selectedRestaurant: RestaurantCardViewModel?
    
    var body: some View {
        List(viewModel.restaurants) { restaurantVM in
            RestaurantCard(viewModel: restaurantVM)
                .onTapGesture {
                    selectedRestaurant = restaurantVM
                }
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
