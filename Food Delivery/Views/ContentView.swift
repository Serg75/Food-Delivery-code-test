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
        GeometryReader { geometry in
            List(viewModel.restaurants) { restaurantVM in
                RestaurantCard(viewModel: restaurantVM, size: geometry.size)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
