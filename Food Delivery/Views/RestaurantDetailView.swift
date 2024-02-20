//
//  RestaurantDetailView.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import SwiftUI
import Kingfisher

struct RestaurantDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: DetailsViewModel
    @State private var showErrorAlert = false

    init(viewModel: DetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack (alignment: .top) {
            VStack {
                KFImage(viewModel.imageUrl)
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                detailCardView(viewModel: viewModel)
                    .padding(.top, -50)
                    .padding(.horizontal, 16)
            }
            
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(.chevron)
                            .shadow(color: .white.opacity(0.4), radius: 1, x: 0, y: 2)
                    })
                    .padding(.top, 40)
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
        .onReceive(viewModel.$errorMessage) { errorMessage in
            if errorMessage != nil {
                showErrorAlert = true
            }
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

@ViewBuilder
@MainActor
func detailCardView(viewModel: DetailsViewModel) -> some View {
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
