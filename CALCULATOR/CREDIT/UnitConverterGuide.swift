//
//  UnitConverterGuide.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 20/10/2024.
//

import SwiftUI

struct UnitConverterGuide: View {
    @Binding var showPopup: Bool
    @State private var currentSlide = 0
    let totalSlides = 6
    
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
                    Text("Unit Converter")
                        .foregroundColor(THEME.CircleFunctionButton_characterColor)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                        .shadow(radius: 4)
                        .padding()

                    TabView(selection: $currentSlide) {
                        SlideView("arrow.left.arrow.right", description: "Convert with ease and flexibility!", THEME: THEME)
                            .tag(0)
                        SlideView("ruler", "scalemass", "cube", description: "Choose from a variety of unit types", THEME: THEME)
                            .tag(1)
                        SlideView_InRow("l.square", "arrow.right", "r.square", description: "By default, the converter switches from left to right units", THEME: THEME)
                            .tag(2)
                        NumpadSymbol(description: "Tap the value field to enter a number using the numpad", THEME: THEME)
                            .tag(3)
                        SlideView("info.circle", description: "Tap the info icon to learn more about each unit", THEME: THEME)
                            .tag(4)
                        SlideView("heart.fill", description: "Thankyou!", THEME: THEME)
                            .tag(5)
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

struct home: View {
    @State private var showPopup = false
    var THEME = StyleChoices().lightTheme
    var body: some View {
        VStack {
            CalculatorGuide(showPopup: $showPopup, THEME: THEME)
            Button(action: {showPopup.toggle()}) {
                Text("showPopup")
            }
        }
        
    }
}
 
struct SlideView_InRow: View {
    let imageName: String
    var imageName2: String = ""
    var imageName3: String = ""
    var imageName4: String = ""
    let description: String
    let THEME: ThemeStyle
    
    
    init(_ imageName: String,
         _ imageName2: String = "",
         _ imageName3: String = "",
         _ imageName4: String = "",
         description: String,
         THEME: ThemeStyle) {
        self.imageName = imageName
        self.imageName2 = imageName2
        self.imageName3 = imageName3
        self.imageName4 = imageName4
        self.description = description
        self.THEME = THEME
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName).resizable().scaledToFit().padding()
                if !imageName2.isEmpty {Image(systemName: imageName2).resizable().scaledToFit().padding()}
                if !imageName3.isEmpty {Image(systemName: imageName3).resizable().scaledToFit().padding()}
                if !imageName4.isEmpty {Image(systemName: imageName4).resizable().scaledToFit().padding()}
            }
            .foregroundColor(THEME.CircleFunctionButton_characterColor)
            
            Text(description)
                .foregroundColor(THEME.CircleFunctionButton_characterColor.opacity(0.9))
                .font(.system(.title2, design: .rounded))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
                
        }
    }
}



struct NumpadSymbol: View {
    let description: String
    var THEME: ThemeStyle
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "7.square.fill").resizable().scaledToFit()
                    Image(systemName: "8.square.fill").resizable().scaledToFit()
                    Image(systemName: "9.square.fill").resizable().scaledToFit()
                }
                HStack {
                    Image(systemName: "4.square.fill").resizable().scaledToFit()
                    Image(systemName: "5.square.fill").resizable().scaledToFit()
                    Image(systemName: "6.square.fill").resizable().scaledToFit()
                }
                HStack {
                    Image(systemName: "1.square.fill").resizable().scaledToFit()
                    Image(systemName: "2.square.fill").resizable().scaledToFit()
                    Image(systemName: "3.square.fill").resizable().scaledToFit()
                }
                HStack {
                    Image(systemName: "0.square.fill").resizable().scaledToFit()
                }
                
            }
            .foregroundColor(THEME.CircleFunctionButton_characterColor)
            
            Text(description)
                .foregroundColor(THEME.CircleFunctionButton_characterColor.opacity(0.9))
                .font(.system(.title2, design: .rounded))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct UnitConverterGuide_Previews: PreviewProvider {
    static var previews: some View {
        home()
    }
}
