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

    init(viewModel: DetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: viewModel.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }

            detailCard(viewModel: viewModel)
                .padding(.top, -50)
                .padding(.horizontal, 16)
        }
    }
}

@ViewBuilder
@MainActor
func detailCard(viewModel: DetailsViewModel) -> some View {
    VStack(alignment: .leading, spacing: 16.0) {
        Text(viewModel.restaurantName)
            .title()
        Text(viewModel.filtersDescription)
            .subtitle()
        Text(viewModel.statusText)
            .title1()
            .foregroundColor(viewModel.statusColor)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(16)
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .shadow(color: Color.primary.opacity(0.15), radius: 4, x: 0, y: 3)
}


#Preview {
    RestaurantDetailView(viewModel: DetailsViewModel(restaurant: PreviewData.SomeRestaurant))
}
