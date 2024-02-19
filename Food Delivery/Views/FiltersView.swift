//
//  FiltersView.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-19.
//

import SwiftUI
import Kingfisher

struct FiltersView: View {
    @StateObject var viewModel: FiltersViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(viewModel.filters, id: \.id) { filterVM in
                    filterView(viewModel: filterVM)
                 }
                 .listStyle(.plain)
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 48)
    }
    
    @ViewBuilder
    func filterView(viewModel: FilterViewModel) -> some View {
        HStack(spacing: 0) {
            KFImage(viewModel.imageUrl)
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())

            Spacer()
            
            Text(viewModel.filterLabel)
                .title2()
            
            Spacer()
        }
        .frame(width: 144)
        .background(Color(.systemBackground))
        .clipShape(Capsule())
    }
}

#Preview {
    @StateObject var viewModel = FiltersViewModel(
        filterIDs: [
            "5c64dea3-a4ac-4151-a2e3-42e7919a925d",
            "614fd642-3fa6-4f15-8786-dd3a8358cd78",
            "c67cd8a3-f191-4083-ad28-741659f214d7",
            "23a38556-779e-4a3b-a75b-fcbc7a1c7a20"
        ])
    return HStack {
        FiltersView(viewModel: viewModel)
            .padding(.vertical, 10)
    }
    .background(Color.gray)
}
