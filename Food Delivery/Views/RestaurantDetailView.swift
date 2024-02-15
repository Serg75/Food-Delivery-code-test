//
//  RestaurantDetailView.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import SwiftUI

struct RestaurantDetailView: View {
    @StateObject private var viewModel: DetailsViewModel
    @State private var detail: OpenStatus?

    var restaurant: Restaurant
    
    init(viewModel: DetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.restaurant = viewModel.restaurant
    }
    
    var body: some View {
        VStack {
            Text(restaurant.name)
                .font(.title)
                .padding()
            if let detail = detail {
                if detail.isOpen {
                    Text("Open")
                        .font(.headline)
                        .foregroundColor(.green)
                } else {
                    Text("Closed")
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

//struct RestaurantDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantDetailView()
//    }
//}
