//
//  FontStyles.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-16.
//

import Foundation
import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 24).weight(.regular))
    }
}

struct Title1Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 18).weight(.regular))
    }
}

struct Title2Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Poppins", size: 14).weight(.regular))
    }
}

struct SubtitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 16).weight(.regular))
            .foregroundColor(Color(.systemGray))
    }
}

struct Subtitle1Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 12).weight(.bold))
            .foregroundColor(Color(.systemGray))
    }
}

struct Footer1Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Inter", size: 10).weight(.regular))
    }
}

struct SelectedStyle: ViewModifier {
    let isSelected: Bool
    func body(content: Content) -> some View {
        if isSelected {
            content
                .foregroundColor(Color(.systemBackground))
                .background(Color(hex: 0xE2A364))
        } else {
            content
                .foregroundColor(Color.primary)
                .background(Color(.systemBackground))
        }
    }
}


extension View {
    func title() -> some View {
        modifier(TitleStyle())
    }
    
    func title1() -> some View {
        modifier(Title1Style())
    }
    
    func title2() -> some View {
        modifier(Title2Style())
    }
    
    func subtitle() -> some View {
        modifier(SubtitleStyle())
    }
    
    func subtitle1() -> some View {
        modifier(Subtitle1Style())
    }
    
    func footer1() -> some View {
        modifier(Footer1Style())
    }
    
    func isSelected(_ isSelected: Bool) -> some View {
        modifier(SelectedStyle(isSelected: isSelected))
    }
}
