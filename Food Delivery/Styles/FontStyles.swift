//
//  FontStyles.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-16.
//

import Foundation
import SwiftUI

struct Title1Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 18).weight(.regular))
    }
}

struct Subtitle1Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 12).weight(.bold))
            .foregroundColor(Color(.systemGray2))
    }
}

struct Footer1Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Inter", size: 10).weight(.regular))
    }
}

extension View {
    func title1() -> some View {
        modifier(Title1Style())
    }
    
    func subtitle1() -> some View {
        modifier(Subtitle1Style())
    }

    func footer1() -> some View {
        modifier(Footer1Style())
    }
}
