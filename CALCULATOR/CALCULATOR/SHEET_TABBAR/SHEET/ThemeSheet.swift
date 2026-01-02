//
//  Dark_light_switchMode.swift
//  CALCULATOR
//
//  Created by Hung Nguyen on 15/08/2024.
//

import SwiftUI
import UIKit
import Foundation



struct ResolvedImage: View {
    @Binding var currentImage: CustomShape
    var body: some View {
        Image(systemName: currentImage.rawValue)
            .font(.system(size: 190))
            .animation(.easeInOut, value: currentImage)
            .frame(width: 200, height: 200)
    }
}



struct ThemeSheet: View {
    @Environment(\.colorScheme) private var scheme
    @AppStorage("userTheme") private var userTheme: Theme = .Default
    
    @Namespace private var animation
    
    // MORPHING EFFECT VARIABLE
    @AppStorage("currentImage") private var currentImage: CustomShape = .Default
    @State var pickerImage: CustomShape = .Default
    @State var blurRadius: CGFloat = 0
    @State var animationMorph: Bool = false
    @State var non_changedPickerImage = false
    
    // SCALE
    var ScaleEffect: CGFloat
    
    // THEME
    @Binding var THEME: ThemeStyle
    
    var body: some View {
        VStack(spacing: 0) {
            
            
            Canvas {context, size in
                context.addFilter(.alphaThreshold(min: 0.18))
                context.addFilter(.blur(radius: blurRadius >= 60 ? 60 - (blurRadius - 60) : blurRadius))
                
                context.drawLayer { ctx in
                    if let resolvedImage = context.resolveSymbol(id: 1) {
                        ctx.draw(resolvedImage, at: CGPoint(x: size.width / 2, y: size.height / 2), anchor: .center)
                    }
                }
            } symbols: {
                ResolvedImage(currentImage: $currentImage)
                    .tag(1)
            }
            .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
                if non_changedPickerImage == false {
                    if animationMorph {
                        if blurRadius <= 120 {
                            blurRadius += 1.2
                            if blurRadius.rounded() >= 60 {
                                currentImage = pickerImage
                            }
                            if blurRadius.rounded() >= 120 {
                                animationMorph = false
                                blurRadius = 0
                            }
                        }
                    }
                }
                else {
                    if blurRadius <= 120 {
                        blurRadius += 1.2
                        if blurRadius.rounded() == 60 {
                            currentImage = currentImage
                        }
                        if blurRadius.rounded() >= 120 {
                            animationMorph = false
                            non_changedPickerImage = false
                            blurRadius = 0
                        }
                    }
                }
            }
            .onTapGesture {
                non_changedPickerImage = true
            }
            .scaleEffect(ScaleEffect)

            
            
            
            
            
            VStack (spacing: 0){
                HStack(spacing: 0) {
                    ForEach(Theme.allCases, id: \.rawValue) { theme in
                        Number("\(theme.rawValue)", numberColor: userTheme == theme ? .darkGray : .white, fontWeight: .bold, fontSize: 15)
                            .scaleEffect(userTheme == theme ? 1.3 : 1)
                            .animation(.easeInOut(duration: 0.3), value: userTheme)
                            .padding(.vertical, 12)
                            .frame(width: 100)
                            .background {
                                ZStack {
                                    if userTheme == theme {
                                        RoundedRectangle(cornerRadius: 45)
                                            .fill(.white)
                                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                    }
                                }
                                .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.3, blendDuration: 0.3), value: userTheme)
                            }
                            .onTapGesture {
                                userTheme = theme
                                if theme == .light {
                                    pickerImage = .Sun
                                    THEME = StyleChoices().lightTheme
                                }
                                else if theme == .dark {
                                    pickerImage = .Moon
                                    THEME = StyleChoices().darkTheme
                                }
                                else {
                                    pickerImage = .Default
                                    THEME = StyleChoices().defaultTheme
                                }
                                animationMorph = true
                            }
                    }
                }
                .padding(3.5)
                .shadow(radius: 5)
                .background(RoundedRectangle(cornerRadius: 45).opacity(0.25))
                .padding(.top, 60)
                
                Text("Choose your style")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(
                        userTheme.colorScheme == .dark ? .offWhite : userTheme.colorScheme == .light ? .darkGray : .offWhite
                    )
                    .padding(.top, 10)
            }
            .offset(y: -20)
            .scaleEffect(ScaleEffect)
        }
        .background(
            Group {
                if userTheme.colorScheme == .light {
                    LinearGradient(.offWhite, .offWhite)
                }
                else if userTheme.colorScheme == .dark {
                    LinearGradient(.darkStart, .darkEnd)
                }
                else {
                    LinearGradient(.darkOffWhite2, .gray)
                }
            }
        )
        .animation(.easeInOut(duration: 2.5), value: userTheme)
        .clipShape(RoundedRectangle(cornerRadius: 30)).ignoresSafeArea()
    }
}


// THEME_IMAGE

enum CustomColorScheme {
    case Default
    case light
    case dark
}

enum Theme: String, CaseIterable {
    case Default = "Default"
    case light = "Light"
    case dark = "Dark"
    
    func color(_ scheme: CustomColorScheme) -> Color {
        switch self {
        case .Default:
                return .darkOffWhite2
        case .light:
                return .offWhite
        case .dark:
                return .gray
        }
    }
    
    var colorScheme: CustomColorScheme {
        switch self {
        case .Default:
            return .Default
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

enum CustomShape: String, CaseIterable {
    case Default = "cloud.sun.fill"
    case Sun = "sun.max.fill"
    case Moon = "moon.fill"
}




// PREVIEW SHEET
struct Home: View {
    @State private var changeTheme: Bool = false
    @State private var extraOprator: Bool = false
    @AppStorage("userTheme") private var userTheme: Theme = .Default
    @State var theme: ThemeStyle = StyleChoices().lightTheme
    var body: some View {
        VStack {
            Button("change theme") {
                changeTheme.toggle()
            }

            Button("extra operator") {
                extraOprator.toggle()
            }
        }
        .halfSheet(showSheet: $changeTheme) {
            ThemeSheet(ScaleEffect: 1, THEME: $theme)
        } onEnd: {}
        .halfSheet(showSheet: $extraOprator) {
//            ExtraOperatorSheet()
        } onEnd: {}

    }
}

struct Dark_light_switchMode_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}





