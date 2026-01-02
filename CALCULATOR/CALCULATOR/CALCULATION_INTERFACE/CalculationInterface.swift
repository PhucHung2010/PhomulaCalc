//
//  CalculationInterface.swift
//  CALCULATOR
//
//  Created by Hung Nguyen on 14/08/2024.
//

import SwiftUI

struct CalculationInterface: View {
    // Board
    private var boardWidth: CGFloat
    @State private var resultString: String = ""
    @State private var result: String = ""
    @State private var resultType: Int = 2
    @State private var equalPressedCheck: Bool = false
    
    
    // GRID HEIGHT _ WIDTH NUMBER
    /// TINY FUNCTION WIDTH / HEIGHT
    private var tinyFunc_gridWidth: CGFloat
    private var tinyFunc_gridHeight: CGFloat
    
    private var func_gridWidth: CGFloat
    
    private var num_gridWidth: CGFloat
    private var num_gridHeight: CGFloat
    
    private var zeroWidth: CGFloat
    
    // CALCULATION
    @State private var calculateStatus: Bool = true
    @State private var powerNumberSymbol: Bool = false
    @State private var logNumberSymbol: Bool = false
    @State private var complexOperation: Bool = false
    @State private var complexParameter: Bool = false
    
    // LOCK SCREEN
    @State var lockScreenCheck: Bool = true
    
    // Extra operator sheet
    @State private var extraOperator: Bool = false
    @State private var functionOperatorSelection: Int = 1

    

    // SCALE
    private var scaleEffect: CGFloat
    let extraOperatorSheetScale: CGFloat
    
    // THEME
    private var THEME: ThemeStyle

    // INIT
    init(THEME: ThemeStyle = StyleChoices().lightTheme,
         boardWidth: CGFloat = 360,
         tinyFunc_gridWidth: CGFloat = 65,
         tinyFunc_gridHeight: CGFloat = 25,
         func_gridWidth: CGFloat = 25,
         num_gridWidth: CGFloat = 15,
         num_gridHeight: CGFloat = 0,
         scaleEffect: CGFloat = 1,
         extraOperatorSheetScale: CGFloat,
         zeroWidth: CGFloat = 295) {
        
        self.THEME = THEME
        self.boardWidth = boardWidth
        self.tinyFunc_gridWidth = tinyFunc_gridWidth
        self.tinyFunc_gridHeight = tinyFunc_gridHeight
        self.func_gridWidth = func_gridWidth
        self.num_gridWidth = num_gridWidth
        self.num_gridHeight = num_gridHeight
        self.scaleEffect = scaleEffect
        self.extraOperatorSheetScale = extraOperatorSheetScale
        self.zeroWidth = zeroWidth
    }
    
    
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).ignoresSafeArea()

            VStack (spacing: 0){

                // RESULT BOARD VIEW
                ResultBoard(resultString, $result, $resultType, boardWidth, THEME: THEME, equalPressedCheck, $calculateStatus, $lockScreenCheck).frame(height: 190)

                Spacer().frame(height: 15)
                // TINY FUNCTION BUTTON
                
                if functionOperatorSelection == 1 {
                    VStack (spacing: tinyFunc_gridHeight){
                        HStack {

                            Button(action: {numberPressed(&resultString, &result, "%", &calculateStatus, &equalPressedCheck)})
                                { Number("%", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .semibold ,fontSize: 28) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.8, THEME: THEME))

                            Button(action: {moduloPressed(&resultString, &result, &calculateStatus, resultType, &equalPressedCheck)})
                            { Number("mod", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .bold ,fontSize: 17.5) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.35, THEME: THEME))

                            Button(action: {numberPressed(&resultString, &result, "𝐞", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                { Number("𝐞", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .semibold ,fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.8, THEME: THEME))

                            Button(action: {numberPressed(&resultString, &result, "𝝿", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                { Number("𝝿", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .bold ,fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.3, THEME: THEME))

                            Button(action: {
                                withAnimation(.spring(response: 0.45, dampingFraction: 0.68)) {
                                    functionOperatorSelection+=1
                                    if functionOperatorSelection == 4 {
                                        functionOperatorSelection = 1
                                    }
                                }
                            })
                                { xPowySymbol(baseLetter: "1", exponentLetter: "st", numberColor: THEME.MoreFuncButton_characterColor, fontWeight: .bold) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.4, THEME: THEME, moreButton: true))
                        }

                        HStack {
                            Button(action: {squarePressed(resultString: &resultString, &result, &calculateStatus, resultType, &equalPressedCheck)})
                                { Number("x²", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .semibold ,fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth + 1)
                                .buttonStyle(TinyFuncButtonStyle(THEME: THEME))

                            Button(action: {powerPressed(&resultString, result, resultType, &complexOperation, &powerNumberSymbol, &equalPressedCheck)})
                                {xPowySymbol(numberColor: THEME.TinyFuncButton_characterColor)}
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.2, THEME: THEME))

                            Button(action: {squareRootPressed(&resultString, result, &resultType, &equalPressedCheck)})
                                { Number("√", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .semibold ,fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth + 1)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.45, THEME: THEME))

                            Button(action: {factorialPressed(&resultString, &result, &calculateStatus, resultType, &equalPressedCheck)})
                                { Number("x!", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .semibold ,fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth + 1)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.15, THEME: THEME))

                            Button(action: {logaritPressed(&resultString, &result, &calculateStatus, resultType, &complexOperation, &logNumberSymbol, &equalPressedCheck)})
                                { Number("log", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .bold ,fontSize: 20) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.9, THEME: THEME))
                        }


                        HStack {
                            Button(action: {numberPressed(&resultString, &result, "(", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                { Number("(", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .semibold ,fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.85, THEME: THEME))

                            Button(action: {numberPressed(&resultString, &result, ")", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                { Number(")", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .semibold ,fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.85, THEME: THEME))

                            Button(action: {SinCosTanPressed("cos", &resultString, result, resultType, &equalPressedCheck)})
                                { Number("cos", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .bold ,fontSize: 20) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.7, THEME: THEME))

                            Button(action: {SinCosTanPressed("sin", &resultString, result, resultType, &equalPressedCheck)})
                                { Number("sin", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .bold ,fontSize: 20) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.1, THEME: THEME))

                            Button(action: {SinCosTanPressed("tan", &resultString, result, resultType, &equalPressedCheck)})
                                { Number("tan", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .bold ,fontSize: 20) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.85, THEME: THEME))
                        }
                    }
                    .transition(.asymmetric(insertion: .offset(x: -500), removal: .offset(x: -500)))
                }
                else if functionOperatorSelection == 2 {
                    VStack (spacing: tinyFunc_gridHeight){
                        HStack {

                            Button(action: {numberPressed(&resultString, &result, "‰", &calculateStatus, &equalPressedCheck)})
                                { Number("‰", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .semibold ,fontSize: 30) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.6, THEME: THEME))

                            Button(action: {enterExponentPressed(&resultString, result, resultType, &equalPressedCheck)})
                                { Number("𝐄𝐄", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .bold ,fontSize: 23) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.6, THEME: THEME))

                            Button(action: {constantPowerPressed("𝐞" ,&resultString, &result, &calculateStatus, resultType, &complexOperation, &powerNumberSymbol, &equalPressedCheck)})
                                { xPowySymbol(baseLetter: "𝐞", exponentLetter: "𝔁", numberColor: THEME.TinyFuncButton_characterColor) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.1, THEME: THEME))

                            Button(action: {constantPowerPressed("𝝿" ,&resultString, &result, &calculateStatus, resultType, &complexOperation, &powerNumberSymbol, &equalPressedCheck)})
                                { xPowySymbol(baseLetter: "𝝿", exponentLetter: "𝔁", numberColor: THEME.TinyFuncButton_characterColor) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.1, THEME: THEME))

                            Button(action: {
                                withAnimation(.spring(response: 0.45, dampingFraction: 0.68)) {
                                    functionOperatorSelection+=1
                                    if functionOperatorSelection == 4 {
                                        functionOperatorSelection = 1
                                    }
                                }
                            }) {
                                xPowySymbol(baseLetter: "2", exponentLetter: "nd", numberColor: THEME.MoreFuncButton_characterColor, fontWeight: .bold)
                            }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.4, THEME: THEME, moreButton: true))
                        }

                        HStack {
                            Button(action: {constantPowerPressed("10" ,&resultString, &result, &calculateStatus, resultType, &complexOperation, &powerNumberSymbol, &equalPressedCheck)})
                            { xPowySymbol(baseLetter: "10", exponentLetter: "x", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 20) }
                                .frame(width: tinyFunc_gridWidth + 1)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.5, THEME: THEME))

                            Button(action: {numberPressed(&resultString, &result, "Φ", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                {Number("Φ", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 25)}
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.1, THEME: THEME))

                            Button(action: {numberPressed(&resultString, &result, "ψ", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                {  Number("Ψ", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth + 1)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.1, THEME: THEME))

                            Button(action: {numberPressed(&resultString, &result, "∁", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                { Number("∁", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth + 1)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.1, THEME: THEME))

                            Button(action: {logaritPressed(&resultString, &result, &calculateStatus, resultType, &complexOperation, &logNumberSymbol, &equalPressedCheck)})
                                { Number("log", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .bold ,fontSize: 20) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.9, THEME: THEME))
                        }


                        HStack {
                            Button(action: {numberPressed(&resultString, &result, "(", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                { Number("(", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .semibold ,fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.85, THEME: THEME))

                            Button(action: {numberPressed(&resultString, &result, ")", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                { Number(")", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .semibold ,fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.85, THEME: THEME))

                            Button(action: {SinCosTanPressed("arccos", &resultString, result, resultType, &equalPressedCheck)})
                                { Number("arccos", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .bold ,fontSize: 16) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.2, THEME: THEME))

                            Button(action: {SinCosTanPressed("arccos", &resultString, result, resultType, &equalPressedCheck)})
                                { Number("arcsin", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .bold ,fontSize: 17) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.2, THEME: THEME))

                            Button(action: {SinCosTanPressed("arccos", &resultString, result, resultType, &equalPressedCheck)})
                                { Number("arctan", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .bold ,fontSize: 17) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.2, THEME: THEME))
                        }
                    }
                    .transition(.asymmetric(insertion: .offset(x: 500), removal: .offset(x: -500)))
                }
                else {
                    VStack (spacing: tinyFunc_gridHeight){
                        HStack {
                            Button(action: {complexParameterFunctionPressed("GCD", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)})
                                { Number("GCD", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 17.5) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.6, THEME: THEME))

                            Button(action: {complexParameterFunctionPressed("LCM", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)})
                            { Number("LCM", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 17.5) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.6, THEME: THEME))

                            Button(action: {complexParameterFunctionPressed("nCr", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)})
                                { Number("nCr", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 20) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.1, THEME: THEME))

                            Button(action: {complexParameterFunctionPressed("nPr", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)})
                                { Number("nPr", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 20) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.1, THEME: THEME))

                            Button(action: {
                                withAnimation(.spring(response: 0.45, dampingFraction: 0.68)) {
                                    functionOperatorSelection+=1
                                    if functionOperatorSelection == 4 {
                                        functionOperatorSelection = 1
                                    }
                                }
                            }) {
                                xPowySymbol(baseLetter: "3", exponentLetter: "rd", numberColor: THEME.MoreFuncButton_characterColor, fontWeight: .bold)
                            }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.4, THEME: THEME, moreButton: true))
                        }
                        .frame(height: 32)

                        HStack {
                            Button(action: {complexParameterFunctionPressed("mean", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)})
                            {Number("mean", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 18)}
                                .frame(width: tinyFunc_gridWidth + 1)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.5, THEME: THEME))

                            Button(action: {complexParameterFunctionPressed("median", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)})
                            {Number("median", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 14)}
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.1, THEME: THEME))

                            Button(action: {complexParameterFunctionPressed("max", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)})
                            {Number("max", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 18)}
                                .frame(width: tinyFunc_gridWidth + 1)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.1, THEME: THEME))

                            Button(action: {complexParameterFunctionPressed("min", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)})
                            {Number("min", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 18)}
                                .frame(width: tinyFunc_gridWidth + 1)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 2.1, THEME: THEME))

                            Button(action: {randomPressed(&resultString, &result, &calculateStatus, powerNumberSymbol, logNumberSymbol)})
                                {Number("random", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 15)}
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.1, THEME: THEME))
                        }
                        .frame(height: 32)


                        HStack {
                            Button(action: {numberPressed(&resultString, &result, "(", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                { Number("(", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .semibold ,fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.85, THEME: THEME))

                            Button(action: {numberPressed(&resultString, &result, ")", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                { Number(")", numberColor: THEME.TinyFuncButton_characterColor,fontWeight: .semibold ,fontSize: 25) }
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.85, THEME: THEME))

                            Button(action: {complexParameterFunctionPressed("randEle", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)})
                                {Number("randEle", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 15)}
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.2, THEME: THEME))

                            Button(action: {complexParameterFunctionPressed("randInt", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)})
                                {Number("randInt", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 15)}
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.2, THEME: THEME))

                            Button(action: {complexParameterFunctionPressed("randReal", &resultString, result, resultType, &complexOperation, &complexParameter, &equalPressedCheck)})
                                {Number("randRea", numberColor: THEME.TinyFuncButton_characterColor, fontSize: 14)}
                                .frame(width: tinyFunc_gridWidth)
                                .buttonStyle(TinyFuncButtonStyle(symbolScaleEffect: 1.2, THEME: THEME))
                        }
                        .frame(height: 32)
                    }
                    .transition(.asymmetric(insertion: .offset(x: 500), removal: .offset(x: 500)))
                }
            

                Spacer().frame(height: 25)

                // FUNCTION - NUMBER BUTTON
                /// PLUS - MINUS - MULTIPLY - DIVIDE
                HStack (spacing: func_gridWidth){

                    Button(action: {functionPressed(&resultString, &result, resultType, "+", &calculateStatus, &equalPressedCheck, &powerNumberSymbol)})
                        {Symbol("plus", symbolColor: THEME.CircleFunctionButton_characterColor)}

                    Button(action: {functionPressed(&resultString, &result, resultType, "−", &calculateStatus, &equalPressedCheck, &powerNumberSymbol)})
                        {Symbol("minus", symbolColor: THEME.CircleFunctionButton_characterColor)}

                    Button(action: {functionPressed(&resultString, &result, resultType, "×", &calculateStatus, &equalPressedCheck, &powerNumberSymbol)})
                        {Symbol("multiply", symbolColor: THEME.CircleFunctionButton_characterColor)}

                    Button(action: {functionPressed(&resultString, &result, resultType, "÷", &calculateStatus, &equalPressedCheck, &powerNumberSymbol)})
                        {Symbol("divide", symbolColor: THEME.CircleFunctionButton_characterColor)}
                }
                .buttonStyle(Circle_FunctionButtonStyle(THEME: THEME))

                Spacer().frame(height: 10)

                VStack (spacing: num_gridHeight){
                    /// SEVEN - EIGHT - NINE - CANCEL
                    HStack (spacing: num_gridWidth){
                        Button(action: {numberPressed(&resultString, &result, "7", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                        {Number("7", numberColor: THEME.NumberButton_characterColor)}
                            .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                        Button(action: {numberPressed(&resultString, &result, "8", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                        {Number("8", numberColor: THEME.NumberButton_characterColor)}
                            .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                        Button(action: {numberPressed(&resultString, &result, "9", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                        {Number("9", numberColor: THEME.NumberButton_characterColor)}
                            .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                        Button(action: {backPressed(&resultString, &result, &calculateStatus, &equalPressedCheck, &powerNumberSymbol, &logNumberSymbol, &complexOperation, &complexParameter)})
                        {Symbol("arrow.uturn.backward", symbolColor: THEME.FunctionButton_characterColor)}
                            .buttonStyle(FunctionButtonStyle(THEME: THEME)).frame(width: 80)
                    }
                    .frame(height: 70)

                    /// FOUR - FIVE - SIX - TRASH
                    HStack (spacing: num_gridWidth){
                        Button(action: {numberPressed(&resultString, &result, "4", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                        {Number("4", numberColor: THEME.NumberButton_characterColor)}
                            .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                        Button(action: {numberPressed(&resultString, &result, "5", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                        {Number("5", numberColor: THEME.NumberButton_characterColor)}
                            .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                        Button(action: {numberPressed(&resultString, &result, "6", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                        {Number("6", numberColor: THEME.NumberButton_characterColor)}
                            .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                        Button(action: {trashPressed(&resultString, &result, &equalPressedCheck ,&complexOperation, &complexParameter, &powerNumberSymbol, &logNumberSymbol)})
                        {Symbol("trash", symbolColor: THEME.FunctionButton_characterColor, symbolSize: 40)}
                            .buttonStyle(FunctionButtonStyle(THEME: THEME)).frame(width: 80)
                    }
                    .frame(height: 80)

                    /// ONE - TWO - THREE - EQUAL
                    HStack (spacing: num_gridWidth){
                        Button(action: {numberPressed(&resultString, &result, "1", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                        {Number("1", numberColor: THEME.NumberButton_characterColor)}
                            .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                        Button(action: {numberPressed(&resultString, &result, "2", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                        {Number("2", numberColor: THEME.NumberButton_characterColor)}
                            .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                        Button(action: {numberPressed(&resultString, &result, "3", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                        {Number("3", numberColor: THEME.NumberButton_characterColor)}
                            .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                        Button(action: {equalPressed(&resultString ,&equalPressedCheck, calculateStatus, &powerNumberSymbol, &logNumberSymbol, &complexOperation, &complexParameter)})
                        {Symbol(!complexOperation ? "equal" : "checkmark", symbolColor: THEME.FunctionButton_characterColor, symbolSize: 60)}
                            .animation(.easeInOut(duration: 0.2), value: complexOperation)
                            .buttonStyle(FunctionButtonStyle(heightNum: 140, THEME: THEME)).frame(width: 80).offset(y: 38)
                    }
                    .frame(height: 70)

                    /// ZERO - DOT
                    HStack (spacing: num_gridWidth){
                        if complexParameter {
                                Button(action: {numberPressed(&resultString, &result, ", ", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                {Number("﹐", numberColor: THEME.NumberButton_characterColor)}
                                    .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                                Button(action: {numberPressed(&resultString, &result, "0", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                {Number("0", numberColor: THEME.NumberButton_characterColor)}
                                    .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)

                                Button(action: {numberPressed(&resultString, &result, ".", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                                {Number(".", numberColor: THEME.NumberButton_characterColor)}
                                    .buttonStyle(NumberButtonStyle(THEME: THEME)).frame(width: 80)
                                Spacer().frame(width: num_gridWidth + 60)
                        }
                        else {
                            Button(action: {numberPressed(&resultString, &result, "0", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                            {Number("0", numberColor: THEME.NumberButton_characterColor)}
                                .buttonStyle(NumberButtonStyle(widthNum: zeroWidth, THEME: THEME)).frame(width: 80)

                            Button(action: {numberPressed(&resultString, &result, ".", &calculateStatus, &equalPressedCheck, powerNumberSymbol, logNumberSymbol)})
                            {Number(".", numberColor: THEME.NumberButton_characterColor)}
                                .buttonStyle(NumberButtonStyle(THEME: THEME)).padding().frame(width: 160 + num_gridWidth)
                        }
                    }
                    .animation(.easeInOut(duration: 0.2), value: complexParameter)
                    .frame(height: 80)
                }
                
                
                Spacer().frame(height: 30)
            }
            .scaleEffect(scaleEffect)

        }
    }

}

struct CalculationInterface_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}
