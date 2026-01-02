//
//  FontWeightDesign.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 02/10/2024.
//

import SwiftUI


enum FontWeight: String, CaseIterable {
    case Default = "default"
    case Light = "light"
    case Bold = "bold"
}

struct FontWeightSwitch: View {
    @Namespace private var animation
    @Binding var selectedFont: FontWeight
    var fontDesign: FontDesign
    @Binding var fontReturn: Font.Weight
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(FontWeight.allCases, id: \.rawValue) { font in
                    Number("\(font.rawValue)", numberColor: selectedFont == font ? .darkGray : .white, fontWeight: .bold, fontSize: 12.5)
                        .scaleEffect(selectedFont == font ? 1.2 : 1)
                        .animation(.easeInOut(duration: 0.3), value: selectedFont)
                        .frame(width: 55, height: 30)
                        .background(
                            ZStack {
                                if selectedFont == font {
                                    RoundedRectangle(cornerRadius: 45)
                                        .fill(Color.white)
                                        .matchedGeometryEffect(id: "switch", in: animation)
                                }
                            }
                            .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.3, blendDuration: 0.3), value: selectedFont)
                        )
                        .onTapGesture {
                            selectedFont = font
                            if selectedFont == .Default {
                                fontReturn = .medium
                            }
                            else if selectedFont == .Light {
                                if fontDesign == .Serif {
                                    fontReturn = .regular
                                }
                                else {
                                    fontReturn = .light
                                }
                            }
                            else {
                                fontReturn = .bold
                            }
                        }
                }
            }
            .padding(3.5)
            .shadow(radius: 4)
            .background(RoundedRectangle(cornerRadius: 45).opacity(0.2))
        }
    }
}


//struct FontWeightDesign_Previews: PreviewProvider {
//    static var previews: some View {
//        FontWeightSwitch(selectedFont: FontWeight.Default)
//    }
//}
