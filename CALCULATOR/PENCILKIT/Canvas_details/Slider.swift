//
//  Slider.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 29/09/2024.
//

import SwiftUI

struct CustomSlider: View {
    
    @Binding private var sliderValue: CGFloat
    @State private var isDragging = false
    @State private var boardOffset: CGFloat = 0
    
    @State private var sliderLimit: CGFloat
    
    
    let THEME: ThemeStyle
    
    init(_ sliderValue: Binding<CGFloat>,_ sliderLimit: CGFloat = 100, THEME: ThemeStyle) {
        self._sliderValue = sliderValue
        _sliderLimit = State(initialValue: sliderLimit)
        self.THEME = THEME
    }
    
    var body: some View {
        VStack {
            ZStack {
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.gray.opacity(0.3))
                    .shadow(radius: 10)
                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.lightGray, lineWidth: 2.5))
                    .frame(height: 25)
                
                HStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(LinearGradient(gradient: Gradient(colors: [THEME.ExtraOperatorInfor_linkBackgroundStart, THEME.ExtraOperatorInfor_linkBackgroundEnd]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: CGFloat(sliderValue / sliderLimit) * (UIScreen.main.bounds.width - 90) + 35, height: 25)
                    Spacer()
                }

                HStack {
                    RoundedRectangle(cornerRadius: 45)
                        .fill(Color.white)
                        .frame(width: 55, height: 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 45)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                        )
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
                        .offset(x: CGFloat(sliderValue / sliderLimit) * (UIScreen.main.bounds.width - 90))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    isDragging = true
                                    sliderValue = min(max(5, Double(gesture.location.x / (UIScreen.main.bounds.width - 90) * sliderLimit) - 10), sliderLimit)
                                    
                                    
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.3, blendDuration: 0.1)) {
                                        boardOffset = CGFloat(sliderValue / sliderLimit) * (UIScreen.main.bounds.width - 90) - (UIScreen.main.bounds.width / 2.6)
                                    }
                                }
                                .onEnded { _ in
                                    isDragging = false
                                }
                        )
                        
                    Spacer()
                }
                
                if isDragging {
                    Text("\(Int(sliderValue))")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.darkGray.opacity(0.7))
                        .cornerRadius(30)
                        .offset(x: boardOffset, y: -45)
                        
                }
            }
            .animation(.easeInOut(duration: 0.3), value: isDragging)
            
            .padding(.horizontal, 20)
        }
    }
}

struct TestSlider: View {
    var THEME: ThemeStyle = StyleChoices().defaultTheme
    @State private var sliderColor: Color = .orange
    @State private var currentFontSize: CGFloat = 20
    var body: some View {
        ZStack {
            LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).ignoresSafeArea()
            
            CustomSlider($currentFontSize, THEME: THEME)
        }
        
    }
}

struct Slider_Previews: PreviewProvider {
    static var previews: some View {
        TestSlider()
    }
}
