//
//  CalculatorGuide.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 20/10/2024.
//

import SwiftUI

struct CalculatorGuide: View {
    @Binding var showPopup: Bool
    @State private var currentSlide = 0
    let totalSlides = 9
    
    var THEME: ThemeStyle
    
    var body: some View {
        ZStack {
            
            if showPopup {
                BlurView(style: .systemUltraThinMaterialDark) // Hiệu ứng blur mạnh hơn
                    .ignoresSafeArea()
                    .onTapGesture {
                        // Đóng pop-up khi bấm vào bất kỳ đâu
                        showPopup = false
                        currentSlide = 0
                    }
                    .transition(.opacity)
            }

            // Pop-up Content with blur background
            if showPopup {
                VStack(spacing: 0) {
                    Text("Calculator")
                        .foregroundColor(THEME.CircleFunctionButton_characterColor)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                        .shadow(radius: 4)
                        .padding()

                    TabView(selection: $currentSlide) {
                        SlideView("divide", description: "Achieve accurate results!", THEME: THEME)
                            .tag(0)
                        
                        NumpadSymbol(description: "Use the numpad to input values", THEME: THEME)
                            .tag(1)
                        
                        SlideView_InRow("plus.circle.fill", "minus.circle.fill", "multiply.circle.fill", "divide.circle.fill", description: "Perform basic operations like addition, subtraction, multiplication, and division", THEME: THEME)
                            .tag(2)
                        
                        SlideView("square.grid.3x3", description: "Use the function buttons for more complex calculations", THEME: THEME)
                            .tag(3)
                        
                        SlideView("1.circle.fill", "2.circle.fill", "3.circle.fill", description: "Tap the 1st, 2nd, 3rd icons to use the extended functions", THEME: THEME)
                            .tag(4)
                        
                        SlideView("checkmark.seal.fill", "", "exclamationmark.triangle.fill", description: "Checkmark or exclamation icons indicate if the equation syntax is correct or incorrect", THEME: THEME)
                            .tag(5)
                        
                        SlideView("d.circle.fill", "", "r.circle.fill", description: "Tap the d - r icons to switch between degrees and radians", THEME: THEME)
                            .tag(6)
                        
                        SlideView("equal.square", "", "arrow.3.trianglepath", description: "Switch between different result formats by tapping the equals button, then the three-arrow button. This function is not valid for large results!", THEME: THEME)
                            .tag(7)
                        
                        SlideView("heart.fill", description: "Thankyou!", THEME: THEME)
                            .tag(8)
                    }
                    .shadow(radius: 4)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 350)
                    
                    
                    
                    HStack {
                        if currentSlide <= 0 {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    currentSlide = 1
                                }
                            }) {
                                Number("Start", numberColor: THEME.CircleFunctionButton_characterColor, fontWeight: .bold, fontSize: 30)
                            }
                            .buttonStyle(FunctionButtonStyle(widthNum: 150, heightNum: 50, THEME: THEME))
                            .transition(.scale)
                        }
                        else {
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    currentSlide -= 1
                                }
                            }) {
                                Number("Back", numberColor: THEME.CircleFunctionButton_characterColor, fontWeight: .semibold, fontSize: 25)
                            }
                            .buttonStyle(FunctionButtonStyle(widthNum: 110, heightNum: 45, cornerRadius: 45, THEME: THEME))
                            .transition(.scale)
                            
                            Spacer()

                            if currentSlide < totalSlides - 1 {
                                Button(action: {
                                    withAnimation {
                                        currentSlide += 1
                                    }
                                }) {
                                    Number("Next", numberColor: THEME.CircleFunctionButton_characterColor, fontWeight: .semibold, fontSize: 25)
                                }
                                .buttonStyle(FunctionButtonStyle(widthNum: 110, heightNum: 45, cornerRadius: 45, THEME: THEME))
                                .transition(.scale)
                            } else {
                                Button(action: {
                                    showPopup = false
                                    currentSlide = 0
                                }) {
                                    Number("Got it!", numberColor: THEME.CircleFunctionButton_characterColor, fontWeight: .bold, fontSize: 25)
                                        .padding()
                                        .background(Color.green.opacity(0.6).frame(width: 110, height: 45).cornerRadius(45).shadow(radius: 7))
                                        
                                }
                                .buttonStyle(ScaledButtonStyle(scaleRadius: 0))
                                .transition(.scale)
                            }
                        }
                        
                    }
                    .padding()
                    
                }
                .background(LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).opacity(0.98).cornerRadius(30).shadow(radius: 5))
                .padding()
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.1), value: showPopup)
    }
}

struct CalculatorGuide_Previews: PreviewProvider {
    static var previews: some View {
        home()
    }
}
