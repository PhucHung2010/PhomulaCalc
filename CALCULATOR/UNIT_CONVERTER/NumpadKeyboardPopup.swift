//
//  NumpadKeyboardPopup.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 16/10/2024.
//

import SwiftUI

struct NumpadKeyboardPopup: View {
    
    @Binding var valueString: String
    let THEME: ThemeStyle
    @Binding var showNumpad: Bool
    
    var body: some View {
       
        if showNumpad {
            VStack (spacing: 20){
                HStack (spacing: 20){
                    Button(action: {valueString += "7"})
                    {Number("7", numberColor: THEME.NumberButton_characterColor)}
                        .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                    Button(action: {valueString += "8"})
                    {Number("8", numberColor: THEME.NumberButton_characterColor)}
                        .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                    Button(action: {valueString += "9"})
                    {Number("9", numberColor: THEME.NumberButton_characterColor)}
                        .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                }


                HStack(spacing: 20){
                    Button(action: {valueString += "4"})
                    {Number("4", numberColor: THEME.NumberButton_characterColor)}
                        .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                    Button(action: {valueString += "5"})
                    {Number("5", numberColor: THEME.NumberButton_characterColor)}
                        .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                    Button(action: {valueString += "6"})
                    {Number("6", numberColor: THEME.NumberButton_characterColor)}
                        .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)
                }


                HStack(spacing: 20){
                    Button(action: {valueString += "1"})
                    {Number("1", numberColor: THEME.NumberButton_characterColor)}
                        .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                    Button(action: {valueString += "2"})
                    {Number("2", numberColor: THEME.NumberButton_characterColor)}
                        .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                    Button(action: {valueString += "3"})
                    {Number("3", numberColor: THEME.NumberButton_characterColor)}
                        .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)
                }

                
                HStack (spacing: 20){
                    Button(action: {valueString += "."})
                    {Number(".", numberColor: THEME.NumberButton_characterColor)}
                        .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)
                    
                    Button(action: {valueString += "0"})
                    {Number("0", numberColor: THEME.NumberButton_characterColor)}
                        .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)
                
                    
                    Button(action: {
                        if !valueString.hasPrefix("-") {
                            valueString = "-" + valueString
                        } else { // Nếu valueString chứa dấu trừ ở đầu (số âm), xóa dấu trừ
                            valueString.removeFirst()
                        }
                    })
                    {Symbol("minus.forwardslash.plus",
                            symbolColor: THEME.NumberButton_characterColor,
                            boldFontWeight: true)}
                    .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)
                }
                
                HStack (spacing: 70) {
                    
                    Button(action: {
                        if !valueString.isEmpty {
                            valueString.removeLast()
                        }
                    })
                    {Symbol("arrow.uturn.backward",
                            symbolColor: THEME.NumberButton_characterColor,
                            symbolSize: 40,
                            boldFontWeight: true)}
                    .buttonStyle(NumberButtonStyle(widthNum: 220, heightNum: 75, THEME: THEME))
                    .frame(width: 80, height: 40)
                    
                    Button(action: {
                        withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.6, blendDuration: 0.1)) {
                            showNumpad.toggle()
                        }
                    })
                    {Symbol("checkmark",
                            symbolColor: THEME.NumberButton_characterColor,
                            symbolSize: 40,
                            boldFontWeight: true)}
                    .buttonStyle(NumberButtonStyle(widthNum: 220, heightNum: 75, THEME: THEME))
                    .frame(width: 80, height: 40)
                    
                }
                
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(LinearGradient(colors: [THEME.Board_Color, THEME.Board_Color], startPoint: .top, endPoint: .bottom))
                    .opacity(0.7)
                    .ignoresSafeArea()
                    .shadow(radius: 6)
            )
            .transition(.move(edge: .bottom))
        }
    }
}


struct NumpadKeyboardPopup_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}
