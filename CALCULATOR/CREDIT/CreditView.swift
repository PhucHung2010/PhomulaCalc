//
//  CreditView.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 18/10/2024.
//

import SwiftUI
import UIKit

struct CreditView: View {
    var THEME: ThemeStyle

    @State private var showAppCard = false
    @State private var showContactCard = false


    @State private var ShowConverterGuide = false
    @State private var ShowCalculatorGuide = false
    @State private var ShowNoteGuide = false
    @State private var ExtraOperatorInformation: Bool = false

    var body: some View {
        ZStack {
            LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).ignoresSafeArea()

            VStack (spacing: 5){
                
                Button(action: {showAppCard.toggle()}) {
                    HStack {
                        Image("divide")
                            .scaleEffect(0.3)
                            .background(
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(LinearGradient(Color.darkBlueStart, Color.darkBlueEnd))
                                    .frame(width: 60, height: 60)
                            )
                            .frame(width: 60, height: 60)
                            .shadow(radius: 4)

                        Text("PhormulaCalc")
                            .font(.system(size: 27, weight: .black, design: .rounded))
                            .foregroundStyle(THEME.CircleFunctionButton_characterColor)
                            .frame(width: 200)
                    }
                }
                .buttonStyle(NumberButtonStyle(widthNum: 550, heightNum: 120, cornerRadius: 45, lineWidth: 7, THEME: THEME))
                .halfSheet(showSheet: $showAppCard, fullSizeSheet: true) {
                    AppCard(THEME: THEME)
                } onEnd: {}
                .padding()
                    



                Button(action: {showContactCard.toggle()}) {
                    HStack {
                        Image(systemName: "person.text.rectangle.fill")
                            .font(.system(size: 55, weight: .bold))
                            .foregroundColor(THEME.CircleFunctionButton_characterColor)
                            .background(
                                BlurView(style: .regular)
                                    .mask (
                                        RoundedRectangle(cornerRadius: 11)
                                            .frame(width: 70, height: 57)
                                    )
                            )
                            .shadow(radius: 4)

                        Text("Developer")
                            .font(.system(size: 27, weight: .heavy, design: .rounded))
                            .foregroundColor(THEME.CircleFunctionButton_characterColor)
                            .frame(width: 200)
                    }

                }
                .buttonStyle(NumberButtonStyle(widthNum: 550, heightNum: 120, cornerRadius: 45, lineWidth: 7, THEME: THEME))
                .halfSheet(showSheet: $showContactCard, fullSizeSheet: true) {
                    ContactCard(THEME: THEME)
                } onEnd: {}
                    .padding()


                Button(action: {ShowConverterGuide.toggle()}) {
                    HStack {
                        Image(systemName: "arrow.left.arrow.right")
                            .font(.system(size: 45, weight: .semibold))
                            .foregroundColor(THEME.CircleFunctionButton_characterColor)

                        Text("Converter?")
                            .font(.system(size: 27, weight: .heavy, design: .rounded))
                            .foregroundColor(THEME.CircleFunctionButton_characterColor)
                            .frame(width: 200)
                    }
                }
                .buttonStyle(NumberButtonStyle(widthNum: 550, heightNum: 120, cornerRadius: 45, lineWidth: 7, THEME: THEME))
                .halfSheet(showSheet: $showContactCard, fullSizeSheet: true) {
                    ContactCard(THEME: THEME)
                } onEnd: {}
                .padding()



                Button(action: {ShowCalculatorGuide.toggle()}) {
                    HStack {
                        Image(systemName: "divide")
                            .font(.system(size: 65, weight: .semibold))
                            .foregroundColor(THEME.CircleFunctionButton_characterColor)

                        Text("Calculator?")
                            .font(.system(size: 27, weight: .heavy, design: .rounded))
                            .foregroundColor(THEME.CircleFunctionButton_characterColor)
                            .frame(width: 200)
                    }

                }
                .buttonStyle(NumberButtonStyle(widthNum: 550, heightNum: 120, cornerRadius: 45, lineWidth: 7, THEME: THEME))
                .halfSheet(showSheet: $showContactCard, fullSizeSheet: true) {
                    ContactCard(THEME: THEME)
                } onEnd: {}
                .padding()




                Button(action: {ShowNoteGuide.toggle()}) {
                    HStack {
                        Image(systemName: "pencil.tip.crop.circle")
                            .font(.system(size: 55, weight: .semibold))
                            .foregroundColor(THEME.CircleFunctionButton_characterColor)

                        Text("Note?")
                            .font(.system(size: 27, weight: .heavy, design: .rounded))
                            .foregroundColor(THEME.CircleFunctionButton_characterColor)
                            .frame(width: 200)
                    }

                }
                .buttonStyle(NumberButtonStyle(widthNum: 550, heightNum: 120, cornerRadius: 45, lineWidth: 7, THEME: THEME))
                .halfSheet(showSheet: $showContactCard, fullSizeSheet: true) {
                    ContactCard(THEME: THEME)
                } onEnd: {}
                .padding()


                Button(action: {ExtraOperatorInformation.toggle()}) {
                    HStack {
                        Image(systemName: "function")
                            .font(.system(size: 45, weight: .semibold))
                            .foregroundColor(THEME.CircleFunctionButton_characterColor)

                        Text("Constants\n&Functions")
                            .font(.system(size: 25, weight: .heavy, design: .rounded))
                            .foregroundColor(THEME.CircleFunctionButton_characterColor)
                            .multilineTextAlignment(.center)
                            .frame(width: 200)
                    }

                }
                .buttonStyle(NumberButtonStyle(widthNum: 550, heightNum: 120, cornerRadius: 45, lineWidth: 7, THEME: THEME))
                .halfSheet(showSheet: $ExtraOperatorInformation, fullSizeSheet: true, sheetView: {
                    ExtraOperatorInformationSheet(THEME: THEME)
                }, onEnd: {})
                .padding()
            }

            UnitConverterGuide(showPopup: $ShowConverterGuide, THEME: THEME)
            CalculatorGuide(showPopup: $ShowCalculatorGuide, THEME: THEME)
            NoteGuide(showPopup: $ShowNoteGuide, THEME: THEME)
        }
    }
}








struct AppGuide: View {
    let symbol: String
    let text: String
    let THEME: ThemeStyle
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "\(symbol)")
                    .resizable().scaledToFit().padding()
                    .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
            }

            Text("\(text)")
                .font(.system(.title, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                .frame(minWidth: 180)
        }
        .frame(height: 110)
        .padding()
        .background(
            BlurView(style: .regular)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .frame(minWidth: 355)
                .frame(height: 130)
                .padding()
        )
        .padding()
    }
}









struct CreditView_Previews: PreviewProvider {
    static var previews: some View {
        CreditView(THEME: StyleChoices().lightTheme)
    }
}
