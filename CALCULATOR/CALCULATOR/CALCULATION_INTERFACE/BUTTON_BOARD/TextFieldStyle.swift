//
//  TextFieldStyle.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 29/09/2024.
//

import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.lightOrange]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(radius: 3, x: 2, y: 2)
            .shadow(radius: 3, x: -2, y: -2)
    }
}


struct customViewModifier: ViewModifier {
    var startColor: Color
    var endColor: Color
    var textColor: Color
    var roundedCornes: CGFloat

    func body(content: Content) -> some View {
        content
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
            .font(.system(size: 18, weight: .medium))
    }
}

