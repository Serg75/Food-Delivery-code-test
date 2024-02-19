//
//  ContentView.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RestaurantsViewModel()
    @StateObject private var filtersViewModel = FiltersViewModel(filterIDs: [])
    @State private var filterIDs: [String] = []

    var body: some View {
        VStack {
            FiltersView(viewModel: filtersViewModel)
            
            RestaurantsView(viewModel: viewModel, size: CGSize.zero)
        }
        .background(Color(.systemGray6))
        .onChange(of: viewModel.filters, perform: { value in
            filtersViewModel.setFilters(filterIDs: value)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
