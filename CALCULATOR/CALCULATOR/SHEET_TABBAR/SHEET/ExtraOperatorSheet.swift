//////
//////  Dark_light_switchMode.swift
//////  CALCULATOR
//////
//////  Created by Hung Nguyen on 15/08/2024.
//////
////
//import SwiftUI
//import UIKit
//import Foundation
//import SwiftUI
//import PencilKit
//
//
//struct ExtraOperatorSheet: View {
//
//    let screenMid = UIScreen.main.bounds.height / 1.43
//
//    var THEME: ThemeStyle
//    let scaleEffect: CGFloat
//    @Binding private var resultString: String
//    @Binding private var result: String
//    @Binding private var resultType: Int
//    @Binding private var equalPressedCheck: Bool
//    @Binding private var calculateStatus: Bool
//    @Binding private var complexOperation: Bool
//    @Binding private var complexParameter: Bool
//    @Binding private var powerNumberSymbol: Bool
//    @Binding private var logNumberSymbol: Bool
//
//
//
//    init(_ THEME: ThemeStyle,
//         _ scaleEffect: CGFloat,
//         _ resultString: Binding<String>,
//         _ result: Binding<String>,
//         _ resultType: Binding<Int>,
//         _ calculateStatus: Binding<Bool>,
//         _ equalPressedCheck: Binding<Bool>,
//         _ complexOperation: Binding<Bool>,
//         _ complexParameter: Binding<Bool>,
//         _ powerNumberSymbol: Binding<Bool>,
//         _ logNumberSymbol: Binding<Bool>) {
//
//        self.THEME = THEME
//        self.scaleEffect = scaleEffect
//        self._resultString = resultString
//        self._result = result
//        self._resultType = resultType
//        self._equalPressedCheck = equalPressedCheck
//        self._calculateStatus = calculateStatus
//        self._complexOperation = complexOperation
//        self._complexParameter = complexParameter
//        self._powerNumberSymbol = powerNumberSymbol
//        self._logNumberSymbol = logNumberSymbol
//    }
//
//
//
//    var body: some View {
//        ZStack {
//            LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).ignoresSafeArea()
//
//                    ScrollView(.vertical, showsIndicators: false) {
//                        VStack(spacing: 80) {
//
//
//                            Spacer().frame(height: 0)
//
//
//                            GeometryReader { geo in
//                                let mid = geo.frame(in: .global).midY
//                                HStack (spacing: 45){
//                                    Button(action: {SinCosTanPressed("arccos", &resultString, result, resultType, &equalPressedCheck)}) {
//                                        Number("arccos", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 23).frame(width: 80)
//                                    }
//                                    Button(action: {SinCosTanPressed("arcsin", &resultString, result, resultType, &equalPressedCheck)}) {
//                                        Number("arcsin", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 23).frame(width: 80)
//                                    }
//                                    Button(action: {SinCosTanPressed("arctan", &resultString, result, resultType, &equalPressedCheck)}) {
//                                        Number("arctan", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 23).frame(width: 80)
//                                    }
//                                }
//                                .buttonStyle(extraOperatorButtonStyle(widthNum: 170, symbolScaleEffect: 1.5, Scale(abs(screenMid - mid)), Opacity(abs(screenMid - mid)), RotationEffect(mid, screenMid, abs(screenMid - mid)), THEME: THEME)).padding().padding()
//                            }
//
//
//                            GeometryReader { geo in
//                                let mid = geo.frame(in: .global).midY
//                                HStack (spacing: 45){
//                                    Button(action: {numberPressed(&resultString, &result, "%", &calculateStatus, &equalPressedCheck)}) {
//                                        Number("%", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 30).frame(width: 80)
//                                    }
//                                    Button(action: {numberPressed(&resultString, &result, "‰", &calculateStatus, &equalPressedCheck)}) {
//                                        Number("‰", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 30).frame(width: 80)
//                                    }
//                                    Button(action: {oneDivideXPressed(&resultString, &result, resultType, &calculateStatus, &equalPressedCheck)}) {
//                                        Number("1|x", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 30).frame(width: 80)
//                                    }
//                                }
//                                .frame(height: 20)
//                                .buttonStyle(extraOperatorButtonStyle(widthNum: 170, symbolScaleEffect: 2.0, Scale(abs(screenMid - mid)), Opacity(abs(screenMid - mid)), RotationEffect(mid, screenMid, abs(screenMid - mid)), THEME: THEME)).padding().padding()
//                            }
//
//
//
//                            GeometryReader { geo in
//                                let mid = geo.frame(in: .global).midY
//                                HStack (spacing: 30){
//                                    Button(action: {constantPowerPressed("𝐞" ,&resultString, &result, &calculateStatus, resultType, &complexOperation, &powerNumberSymbol, &equalPressedCheck)}) {
//                                        xPowySymbol(baseLetter: "𝐞", exponentLetter: "𝔁", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 35, exponentFontSize: 20).frame(width: 60)
//                                    }
//                                    Button(action: {constantPowerPressed("𝝿" ,&resultString, &result, &calculateStatus, resultType, &complexOperation, &powerNumberSymbol, &equalPressedCheck)}) {
//                                        xPowySymbol(baseLetter: "𝝿", exponentLetter: "𝔁", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 35, exponentFontSize: 20).frame(width: 60)
//                                    }
//                                    Button(action: {constantPowerPressed("10" ,&resultString, &result, &calculateStatus, resultType, &complexOperation, &powerNumberSymbol, &equalPressedCheck)}) {
//                                        xPowySymbol(baseLetter: "10", exponentLetter: "𝔁", numberColor: THEME.TinyFuncButton_characterColor, fontWeight: .bold, fontSize: 25, exponentFontSize: 20).frame(width: 60)
//                                    }
//                                    Button(action: {enterExponentPressed(&resultString, result, resultType, &equalPressedCheck)}) {
//                                        Number("𝐄𝐄", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 25).frame(width: 60)
//                                    }
//                                }
//                                .frame(height: 20)
//                                .buttonStyle(extraOperatorButtonStyle(widthNum: 130, symbolScaleEffect: 1.9, Scale(abs(screenMid - mid)), Opacity(abs(screenMid - mid)), RotationEffect(mid, screenMid, abs(screenMid - mid)), THEME: THEME)).padding().padding()
//                            }
//
//
//
//                            GeometryReader { geo in
//                                let mid = geo.frame(in: .global).midY
//                                HStack (spacing: 30){
//                                    Button(action: {complexParameterFunctionPressed("GCD", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)}) {
//                                        Number("GCD", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 20).frame(width: 60)
//                                    }
//                                    Button(action: {complexParameterFunctionPressed("LCM", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)}) {
//                                        Number("LCM", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 20).frame(width: 60)
//                                    }
//                                    Button(action: {complexParameterFunctionPressed("nCr", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)}) {
//                                        Number("nCr", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 20).frame(width: 60)
//                                    }
//                                    Button(action: {complexParameterFunctionPressed("nPr", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)}) {
//                                        Number("nPr", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 20).frame(width: 60)
//                                    }
//                                }
//                                .buttonStyle(extraOperatorButtonStyle(widthNum: 130, symbolScaleEffect: 1.9, Scale(abs(screenMid - mid)), Opacity(abs(screenMid - mid)), RotationEffect(mid, screenMid, abs(screenMid - mid)), THEME: THEME)).padding().padding()
//                            }
//
//
//
//                            GeometryReader { geo in
//                                let mid = geo.frame(in: .global).midY
//                                HStack (spacing: 30){
//                                    Button(action: {complexParameterFunctionPressed("mean", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)}) {
//                                        Number("mean", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 18).frame(width: 60)
//                                    }
//                                    Button(action: {complexParameterFunctionPressed("median", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)}) {
//                                        Number("median", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 17).frame(width: 60)
//                                    }
//                                    Button(action: {complexParameterFunctionPressed("max", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)}) {
//                                        Number("max", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 18).frame(width: 60)
//                                    }
//                                    Button(action: {complexParameterFunctionPressed("min", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)}) {
//                                        Number("min", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 18).frame(width: 60)
//                                    }
//                                }
//                                .buttonStyle(extraOperatorButtonStyle(widthNum: 130, symbolScaleEffect: 1.3, Scale(abs(screenMid - mid)), Opacity(abs(screenMid - mid)), RotationEffect(mid, screenMid, abs(screenMid - mid)), THEME: THEME)).padding().padding()
//                            }
//
//
//
//                            GeometryReader { geo in
//                                let mid = geo.frame(in: .global).midY
//                                HStack (spacing: 27){
//                                    Button(action: {randomPressed(&resultString, &result, &calculateStatus, powerNumberSymbol, logNumberSymbol)}) {
//                                        Number("random", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 16).frame(width: 60)
//                                    }
//                                    Button(action: {complexParameterFunctionPressed("randEle", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)}) {
//                                        Number("randEle", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 16).frame(width: 65)
//                                    }
//                                    Button(action: {complexParameterFunctionPressed("randInt", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)}) {
//                                        Number("randInt", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 16).frame(width: 60)
//                                    }
//                                    Button(action: {complexParameterFunctionPressed("randReal", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)}) {
//                                        Number("randReal", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 15).frame(width: 65)
//                                    }
//                                }
//                                .buttonStyle(extraOperatorButtonStyle(widthNum: 130, symbolScaleEffect: 1.3, Scale(abs(screenMid - mid)), Opacity(abs(screenMid - mid)), RotationEffect(mid, screenMid, abs(screenMid - mid)), THEME: THEME)).padding().padding()
//                            }
//
//
//
//                            GeometryReader { geo in
//                                let mid = geo.frame(in: .global).midY
//                                HStack (spacing: 45){
//                                    Button(action: {numberPressed(&resultString, &result, "Φ", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)}) {
//                                        Number("Φ", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 30).frame(width: 80)
//                                    }
//                                    Button(action: {numberPressed(&resultString, &result, "ψ", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)}) {
//                                        Number("Ψ", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 30).frame(width: 80)
//                                    }
//                                    Button(action: {numberPressed(&resultString, &result, "∁", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)}) {
//                                        Number("∁", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 35).frame(width: 80)
//                                    }
//                                }
//                                .frame(height: 20)
//                                .buttonStyle(extraOperatorButtonStyle(widthNum: 170, symbolScaleEffect: 2.0, Scale(abs(screenMid - mid)), Opacity(abs(screenMid - mid)), RotationEffect(mid, screenMid, abs(screenMid - mid)), THEME: THEME)).padding().padding()
//                            }
//
//
//                            Spacer().frame(height: 15)
//
//                        }
//                        .scaleEffect(scaleEffect)
//                        .frame(width: 400)
//                    }
//
//        }
//    }
//
//
//
//    func Scale(_ distanceFromCenter: CGFloat) -> CGFloat {
//        distanceFromCenter > 180 ? (1.0 - min(distanceFromCenter / 1300, 1)) : 1
//    }
//
//    func Opacity(_ distanceFromCenter: CGFloat) -> CGFloat {
//        distanceFromCenter > 180 ? (1.0 - min(distanceFromCenter / 500, 1)) : 1
//    }
//
//    func RotationEffect(_ mid: CGFloat, _ screenMid: CGFloat, _ distanceFromCenter: CGFloat) -> Angle {
//        let up = min((distanceFromCenter / 500) * 20, 20)
//        let down = min((distanceFromCenter / 500) * -3, -3)
//        let rotationAngle: Double = (mid < screenMid) ? up : down
//
//        let Guard = distanceFromCenter > 180 ? rotationAngle : 0
//        return Angle.degrees(Guard)
//    }
//}
//
//
//struct ExtraOperator_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentViewCalculator()
//    }
//}
//
