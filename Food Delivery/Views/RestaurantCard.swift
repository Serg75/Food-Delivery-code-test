//
//  RestaurantCard.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import SwiftUI

struct RestaurantCard: View {
    var restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "photo") // Placeholder image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            Text(restaurant.name)
                .font(.headline)
            Text("Delivery Time: \(restaurant.delivery_time_minutes) mins")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

