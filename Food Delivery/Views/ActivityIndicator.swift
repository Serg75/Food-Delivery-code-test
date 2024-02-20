//
//  ActivityIndicator.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-14.
//

import SwiftUI

struct ActivityIndicator: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        if isAnimating {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
}

#Preview {
    @State var isAnimating = true
    return ActivityIndicator(isAnimating: $isAnimating)
}
