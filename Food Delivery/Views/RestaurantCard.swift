//
//  RestaurantCard.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import SwiftUI
import Kingfisher

struct RestaurantCard: View {
    @StateObject private var viewModel: RestaurantCardViewModel
    
    let size: CGSize
    
    init(viewModel: RestaurantCardViewModel, size: CGSize) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.size = size
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(viewModel.imageUrl)
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: size.width * 0.35)
                .clipped()
            
            cardView(viewModel: viewModel)
        }
        .background(Color(.systemBackground))
        .clipShape(UnevenRoundedRectangle(
            topLeadingRadius: 12,
            bottomLeadingRadius: 0,
            bottomTrailingRadius: 0,
            topTrailingRadius: 12))
        .shadow(color: Color.primary.opacity(0.15), radius: 4, x: 0, y: 3)
    }
}

@ViewBuilder
@MainActor
func cardView(viewModel: RestaurantCardViewModel) -> some View {
    VStack(alignment: .leading, spacing: 4.0) {
        HStack(alignment: .top) {
            Text(viewModel.restaurantName)
                .title1()

            Spacer()

            ratingView(ratingValue: viewModel.rating)
                .padding(.top, 3)
        }
        Text(viewModel.filtersDescription)
            .subtitle1()
        HStack {
            Image("clock icon")
                .resizable()
                .frame(width: 10, height: 10)
            Text(viewModel.deliveryTime)
                .footer1()
        }
        .padding(.top, 4.0)
    }
    .padding(.horizontal, 8)
    .padding(.bottom, 8)
}

@ViewBuilder
@MainActor
func ratingView(ratingValue: Double) -> some View {
    HStack() {
        Image("star icon")
            .resizable()
            .frame(width: 10, height: 10)
        
        Text(String(format: "%.1f", ratingValue))
            .footer1()
    }
}

#Preview {
    RestaurantCard(
        viewModel:
            RestaurantCardViewModel(
                restaurant:
                    PreviewData.SomeRestaurant),
        size:
            // iPhone 15 screen size
            CGSize(width: 393, height: 852)
    )
    .padding()
}
