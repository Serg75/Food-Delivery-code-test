//
//  ContentView.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RestaurantsViewModel()

    var body: some View {
        GeometryReader { geometry in
            RestaurantsView(viewModel: viewModel, size: geometry.size)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
