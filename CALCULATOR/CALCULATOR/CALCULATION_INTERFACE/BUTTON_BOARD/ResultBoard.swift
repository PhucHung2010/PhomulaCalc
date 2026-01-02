//
//  ResultBoard.swift
//  CALCULATOR
//
//  Created by Hung Nguyen on 13/08/2024.
//

import SwiftUI

struct ResultBoard_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}



struct ResultBoard: View {
    
    // Result String
    var resultString: String
    @State var optionalResult: String = ""
    @Binding var explicitResult: String
    @Binding var resultType: Int

    
    // Board
    var widthNumber: CGFloat
    var heightNumber: CGFloat
    var THEME: ThemeStyle
    var equalPressedCheck: Bool
    @Binding var calculateStatus: Bool
    @State private var isPressingOnImage: Bool = false
    @Binding var lockScreenCheck: Bool
    @State private var isPressingOnLockScreen: Bool = false
    
    @ObservedObject var globalState = GlobalState_IsUsingRadian.shared
    
    
    init(
        _ resultString: String,
        _ result: Binding<String>,
        _ resultType: Binding<Int>,
        _ widthNumber: CGFloat = 360,
        _ heightNumber: CGFloat =  170,
        THEME: ThemeStyle = StyleChoices().lightTheme,
        _ equalPressedCheck: Bool = false,
        _ calculateStatus: Binding<Bool>,
        _ lockScreenCheck: Binding<Bool>
    )
    {
        self.resultString = resultString
        self._resultType = resultType
        self._explicitResult = result
        self.widthNumber = widthNumber
        self.heightNumber = heightNumber
        self.THEME = THEME
        self.equalPressedCheck = equalPressedCheck
        self._calculateStatus = calculateStatus
        self._lockScreenCheck = lockScreenCheck
    }
    

    var calculateStatusImage: String {
        if resultString == "" {
            return "heart.fill"
        }
        else if !calculateStatus {
            return "exclamationmark.triangle.fill"
        }
        else {
            return "checkmark.seal.fill"
        }
    }
   
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(THEME.Board_Color)
                .frame(width: widthNumber, height: heightNumber)
                .shadow(color: THEME.Board_upShadow.opacity(THEME.Board_upShadow_opacity), radius: THEME.Board_upShadow_radius, x: THEME.Board_upShadow_x_y, y: THEME.Board_upShadow_x_y)
                .shadow(color: THEME.Board_downShadow.opacity(THEME.Board_downShadow_opacity), radius: THEME.Board_downShadow_radius, x: THEME.Board_downShadow_x_y, y: THEME.Board_downShadow_x_y)
                .overlay(
                    
                    VStack {
                        ScrollView(.horizontal) {
                            ScrollViewReader { proxy in
                                HStack {
                                    
                                    FormattedResultString(resultString)
                                        .foregroundColor(THEME.Board_resultStringColor)
                                        .font(.system(size: 30, weight: .bold, design: .rounded))
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                        .lineLimit(1)
                                        .padding()
                                        .id("scrollId")
                                        .background(
                                            GeometryReader { geometry in
                                                Color.clear
                                                    .onAppear {
                                                        DispatchQueue.main.async {
                                                            scrollToEnd(proxy: proxy)
                                                        }
                                                    }
                                                    .onChange(of: resultString.count) { _ in
                                                        DispatchQueue.main.async {
                                                            scrollToEnd(proxy: proxy)
                                                        }
                                                    }
                                            }
                                        )
                                }
                            }
                        }

                            
                        ScrollView(.horizontal) {
                            HStack {
                                formattedResult(optionalResult, resultType)
                                    .foregroundColor(THEME.Board_resultStringColor.opacity(equalPressedCheck ? 1.0 : 0.5))
                                    .font(.system(size: 30, weight: equalPressedCheck ? .bold : .semibold, design: .rounded))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                    .padding()
                                    .lineLimit(1)
                                    .scaleEffect(equalPressedCheck ? 1 : 0.85)
                                    .animation(.easeInOut(duration: 0.3), value: equalPressedCheck)
                                    .animation(.easeOut(duration: 0.1), value: optionalResult)
                                    .onChange(of: explicitResult) { newValue in
                                        optionalResult = switchResultType(explicitResult, &resultType)
                                    }
                            }
                            .offset(x: resultOffset(for: optionalResult, equalPressedCheck, widthNumber))
                        }
       
                    }
                )
            
            
            // Lock Screen
            if lockScreenCheck && calculateStatusImage == "heart.fill"{
                    Text("have a nice day!")
                        .font(.system(size: 20, weight: .light, design: .serif))
                        .foregroundColor(heartColor(THEME: THEME))
                        .italic()
                        .onLongPressGesture(minimumDuration: 10, pressing: {pressing in
                            self.isPressingOnLockScreen = pressing
                        }, perform: {})
                        .scaleEffect(isPressingOnLockScreen ? 1.7 : 1)
                        .animation(.easeInOut(duration: 0.5), value: isPressingOnLockScreen)
                        .padding(50)
                        .onDisappear {lockScreenCheck = false}
            }

            
            // Calculate Status and Changing Result Type
            VStack {
                Spacer().frame(height: 100)
                HStack {
                    if equalPressedCheck {
                        VStack {
                            
                            if globalState.globalVariable_isAvailableOfTrigonometric {
                                Button(action: {
                                    globalState.globalVariable_isUsingRadian.toggle()
                                    calculate(resultString: resultString, result: &explicitResult, &calculateStatus)
                                }) {
                                    Image(systemName: globalState.globalVariable_isUsingRadian ? "r.circle.fill" : "d.circle.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(heartColor(THEME: THEME))
                                }
                                .buttonStyle(ScaledButtonStyle())
                                .padding(2)
                            }
                            
                            Button(action: {
                                resultType += 1
                                if resultType == 5 {resultType = 1}
                                optionalResult = switchResultType(explicitResult, &resultType)
                            }) {
                                Image(systemName: "arrow.3.trianglepath")
                                    .font(.system(size: 22))
                                    .foregroundColor(heartColor(THEME: THEME))
                            }
                            .buttonStyle(ScaledButtonStyle())
                        }
                        .padding().padding().transition(.scale)
                    }
                    else {
                        VStack {
                            if resultString.contains("sin") || resultString.contains("cos") || resultString.contains("tan") || resultString.contains("arcsin") || resultString.contains("arccos") || resultString.contains("arctan") {
                                
                                Button(action: {
                                    globalState.globalVariable_isUsingRadian.toggle()
                                    calculate(resultString: resultString, result: &explicitResult, &calculateStatus)
                                }) {
                                    Image(systemName: globalState.globalVariable_isUsingRadian ? "r.circle.fill" : "d.circle.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(heartColor(THEME: THEME))
                                }
                                .buttonStyle(ScaledButtonStyle())
                                .padding(2)
                            }
                            
                            
                            Image(systemName: "\(calculateStatusImage)")
                                .font(.system(size: 22))
                                .foregroundColor (
                                    calculateStatusImage == "heart.fill" ? heartColor(THEME: THEME, isPressing: isPressingOnImage)
                                    : calculateStatusImage == "exclamationmark.triangle.fill" ? .red
                                    : .blue
                                )
                                .onLongPressGesture(minimumDuration: 10, pressing: { isPressing in
                                    self.isPressingOnImage = isPressing
                                } ,perform: {})
                                .scaleEffect(isPressingOnImage ? 4 : 1)
                                .animation(.easeInOut(duration: 0.5), value: isPressingOnImage)
                                .animation(.easeInOut(duration: 0.4), value: calculateStatusImage)
                        }
                        
                       
                    }
                    Spacer().frame(width: 300)
                }
                .animation(.easeInOut(duration: 0.3), value: equalPressedCheck)
            }
            
        }
    }
    
    
    
    func switchAgleOption() -> Bool {
        return false
    }
    
    
    func heartColor(THEME: ThemeStyle, isPressing: Bool = false) -> Color {
        if isPressing {return .red}
        
        if THEME.backgroundStart == .offWhite {
            return .darkGray
        }
        else if THEME.backgroundStart == .darkStart {
            return .offWhite
        }
        else {
            return .white
        }
    }
    
    
    private func scrollToEnd(proxy: ScrollViewProxy) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            withAnimation{
                proxy.scrollTo("scrollId", anchor: .trailing)
            }
        }
    }
    
    
    
    
    func resultOffset(for result: String, _ equalPressedCheck: Bool, _ widthNumber: CGFloat) -> CGFloat {
        
        var pad: CGFloat
        
        if containsAnyAlphabet(result) {
            
            if equalPressedCheck {
                pad = CGFloat(Float(widthNumber - 15) - Float(result.count) * 16)
            }
            else {
                pad = CGFloat(Float(widthNumber - 10) - Float(result.count) * 15)
                
                if pad < 0 {
                    return pad / 20
                }
                else {
                    return max(pad, 20)
                }
            }
        }
        else if result.contains("|") {
            let components = result.components(separatedBy: "|")
            let maxLengh = max(components[0].count, components[1].count)

            if equalPressedCheck {
                pad = CGFloat(Float(widthNumber - 40) - Float(maxLengh * 16))
            }
            else {
                pad = CGFloat(Float(widthNumber - 35) - Float(maxLengh * 15))
            }
        }
        else {
            let dotCount = result.filter { $0 == "," || $0 == "(" || $0 == ")" }.count
            
            if equalPressedCheck {
                pad = CGFloat(Float(widthNumber - 35) - Float(result.count) * 16.5)
                pad += CGFloat(Double(dotCount) * 1.5)
            }
            else {
                pad = CGFloat(Float(widthNumber - 30) - Float(result.count) * 16.1)
                pad += CGFloat(Double(dotCount) * 5)
                
                if pad < 0 {
                    return pad / 12.5
                }
                else {
                    return max(pad, 10)
                }
            }
        }
        
        return max(pad, 30)
    }
    
    
    
    
    
    
    // formatt result string
    func FormattedResultString(_ resultString: String) -> Text {
        var result = Text("")
        
        for char in resultString {
            
            if char == "𝐄" {
                result = result + Text(String(char))
                    .font(.system(size: 22, design: .rounded))
                    .fontWeight(.bold)
            }
            // Power
            else if char == "·" {
                result = result + Text(String(char))
                    .font(.system(size: 30, design: .rounded))
                    .baselineOffset(7)
            }
            else if char == "⁺" {
                result = result + Text(String("+"))
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .baselineOffset(14)
            }
            else if char == "⁻" {
                result = result + Text(String("−"))
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .baselineOffset(14)
            }
            else if char == "ˣ" {
                result = result + Text(String("×"))
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .baselineOffset(14)
            }
            else if char == "#" {
                result = result + Text(String("÷"))
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .baselineOffset(14)
            }
            else if char == "⁽" {
                result = result + Text(String("("))
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .baselineOffset(16)
            }
            else if char == "⁾" {
                result = result + Text(String(")"))
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .baselineOffset(16)
            }
            else if isPowerNumber(char) {
                // special constant
                if char == "ᵉ" {
                    result = result + Text(String("𝐞"))
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .baselineOffset(14)
                }
                else if char == "π" {
                    result = result + Text(String("𝝿"))
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .baselineOffset(14)
                }
                else {
                    result = result + Text(String(char))
                        .font(.system(size: 35, weight: .semibold, design: .rounded))
                }
            }
            // logarit
            else if isLogNumber(char) {
                if char == "𝔢" {
                    result = result + Text(String("𝐞"))
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .baselineOffset(-6)
                }
                else if char == "Π" {
                    result = result + Text(String("𝝿"))
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .baselineOffset(-6)
                }
                else {
                    result = result + Text(String(char))
                        .font(.system(size: 35, weight: .semibold, design: .rounded))
                        .baselineOffset(-3)
                }
            }
            else if char == "․" {
                result = result + Text(String("."))
                    .font(.system(size: 35, design: .rounded))
                    .baselineOffset(-9)
            }
            else {
                result = result + Text(String(char))
            }
            
        }
        
        return result
    }
    
    
    
    // format for result type
    func formattedResult(_ result: String, _ resultType: Int) -> some View {
        if resultType == 4 {
            let components = result.components(separatedBy: "|")
            if components.count == 2 {
                let numerator = components[0]
                let denominator = components[1]
                
                return AnyView(
                    GeometryReader { geometry in
                        VStack (spacing: 3){
                            Text(numerator)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                            Capsule()
                                .frame(width: CGFloat(max(numerator.count, denominator.count)) * 16.5, height: 3)
                            Text(denominator)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    .frame(width: CGFloat(max(numerator.count, denominator.count) * 17), height: 50) // Kích thước khung chứa
                )
            }
        }
        return AnyView(Text(result))
    }
    
}


// switch result type

func switchResultType(_ explicitResult: String, _ resultType: inout Int) -> String {
    var optionalResult: String = ""
    let maxDecimalDigits = calculateMaxDecimalDigits(for: Double(explicitResult.replacingOccurrences(of: ",", with: "")) ?? 0)
    
    // spellout - format - half explicit - full explicit - fraction
    
    switch resultType {
    case 1:
        if Double(explicitResult.replacingOccurrences(of: ",", with: "")) ?? 0 > 37000000000000000 { fallthrough }
        optionalResult = spellOutResult(explicitResult)
    case 2:
        optionalResult = formatRepeatingDecimal(explicitResult, maxDecimalDigits)
    case 3:
        if formatRepeatingDecimal(explicitResult, maxDecimalDigits).contains("(") {
            optionalResult = expandRepeatingDecimal(explicitResult, maxDecimalDigits)
        }
        else {
            resultType += 1
            fallthrough
        }
    case 4:
        optionalResult = floatToFraction(explicitResult, maxDecimalDigits)
        if optionalResult.contains("∞") { fallthrough }
    default:
        optionalResult = formatRepeatingDecimal(explicitResult, maxDecimalDigits)
    }
    
    return optionalResult
}


func spellOutResult(_ explicitResult: String) -> String {
    var optionalResult: String = ""
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .spellOut
    numberFormatter.locale = Locale(identifier: "en_US")
    
    
    if let numberValue = Double(explicitResult.replacingOccurrences(of: ",", with: "")), let formattedResult = numberFormatter.string(from: NSNumber(value: numberValue)) {
        optionalResult = formattedResult
    }
    return optionalResult
}
