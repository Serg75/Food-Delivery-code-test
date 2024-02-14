//
//  ContentView.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RestaurantsViewModel()
    @State private var selectedRestaurant: Restaurant?
    
    var body: some View {
        List(viewModel.restaurants) { restaurant in
            RestaurantCard(restaurant: restaurant)
                .onTapGesture {
                    selectedRestaurant = restaurant
                }
        }
        .navigationBarTitle("Restaurants")
        .overlay(ActivityIndicator(isAnimating: $viewModel.isLoading))
        .sheet(item: $selectedRestaurant) { restaurant in
            RestaurantDetailView(viewModel: DetailsViewModel(restaurant: restaurant))
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
