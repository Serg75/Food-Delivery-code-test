//
//  ContentView.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var restaurantsVM = RestaurantsViewModel()
    @StateObject private var filtersVM = FiltersViewModel(filterIDs: [])
    @State private var showErrorAlert = false

    var body: some View {
        VStack {
            HStack {
                Image(.logo)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 10)
            
            FiltersView(filtersVM: filtersVM)
            
            RestaurantsView(viewModel: restaurantsVM)
        }
        .background(Color(.systemGray6))
        .onChange(of: restaurantsVM.allFilterIDs, perform: { value in
            filtersVM.setFilters(filterIDs: value)
        })
        .onChange(of: filtersVM.filterIDs, perform: { value in
            withAnimation {
                restaurantsVM.filterIDs = value
            }
        })
        .onReceive(restaurantsVM.$errorMessage) { errorMessage in
            if errorMessage != nil {
                showErrorAlert = true
            }
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(restaurantsVM.errorMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    ContentView()
}
