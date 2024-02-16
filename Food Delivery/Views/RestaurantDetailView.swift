//
//  RestaurantDetailView.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import SwiftUI

struct RestaurantDetailView: View {
    @StateObject private var viewModel: DetailsViewModel
    @State private var detail: Status?

    var restaurant: Restaurant
    
    init(viewModel: DetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.restaurant = viewModel.restaurant
    }
    
    var body: some View {
        VStack {
            detailCard(viewModel: viewModel)
        }
    }
}

@ViewBuilder
func detailCard(viewModel: DetailsViewModel) -> some View {
    VStack {
        Text(viewModel.restaurantName)
            .font(.title)
        Text(viewModel.restaurantDescription)
            .font(.title2)
            .foregroundColor(.gray)
    }
    .padding(16)
    .background(Color.green)
    .clipped()
    .cornerRadius(12)
}


#Preview {
    RestaurantDetailView(viewModel: DetailsViewModel(restaurant: PreviewData.SomeRestaurant))
}
