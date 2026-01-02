//
//  ButtonPressed.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 30/08/2024.
//

import Foundation
import SwiftUI


// BUTTON PRESSED

func numberPressed(_ resultString: inout String,
                   _ result: inout String,
                   _ character: String,
                   _ calculateStatus: inout Bool,
                   _ equalPressed: inout Bool,
                   _ powerNumberSymbol: Bool = false,
                   _ logNumberSymbol: Bool = false) -> Void {
    
    var mainChar = character
    if powerNumberSymbol {
        if mainChar == "0" {mainChar = "⁰"}
        else if mainChar == "1" {mainChar = "¹"}
        else if mainChar == "2" {mainChar = "²"}
        else if mainChar == "3" {mainChar = "³"}
        else if mainChar == "4" {mainChar = "⁴"}
        else if mainChar == "5" {mainChar = "⁵"}
        else if mainChar == "6" {mainChar = "⁶"}
        else if mainChar == "7" {mainChar = "⁷"}
        else if mainChar == "8" {mainChar = "⁸"}
        else if mainChar == "9" {mainChar = "⁹"}
        else if mainChar == "." {mainChar = "·"}
        else if mainChar == "(" {mainChar = "⁽"}
        else if mainChar == ")" {mainChar = "⁾"}
        else if mainChar == "𝐞" {mainChar = "ᵉ"}
        else if mainChar == "𝝿" {mainChar = "π"}
    }
    else if logNumberSymbol {
        if mainChar == "0" {mainChar = "₀"}
        else if mainChar == "1" {mainChar = "₁"}
        else if mainChar == "2" {mainChar = "₂"}
        else if mainChar == "3" {mainChar = "₃"}
        else if mainChar == "4" {mainChar = "₄"}
        else if mainChar == "5" {mainChar = "₅"}
        else if mainChar == "6" {mainChar = "₆"}
        else if mainChar == "7" {mainChar = "₇"}
        else if mainChar == "8" {mainChar = "₈"}
        else if mainChar == "9" {mainChar = "₉"}
        else if mainChar == "." {mainChar = "․"}
        else if mainChar == "(" {mainChar = ""}
        else if mainChar == ")" {mainChar = ""}
        else if mainChar == "𝐞" {mainChar = "𝔢"}
        else if mainChar == "𝝿" {mainChar = "Π"}
    }
    resultString += mainChar
    if equalPressed { equalPressed = false }
    calculate(resultString: resultString, result: &result, &calculateStatus)
}






func functionPressed(_ resultString: inout String,
                     _ result: inout String,
                     _ resultType: Int,_ character: String,
                     _ calculateStatus: inout Bool,
                     _ equalPressed: inout Bool,
                     _ powerNumberSymbol: inout Bool) -> Void {
    
    if equalPressed {
        equalPressedSwitch(&resultString, result, resultType, &equalPressed)
    }
    
    var mainChar = character
    if powerNumberSymbol {
        if mainChar == "+" {mainChar = "⁺"}
        else if mainChar == "−" {mainChar = "⁻"}
        else if mainChar == "×" {mainChar = "ˣ"}
        else if mainChar == "÷" {mainChar = "#"}
    }
    resultString += mainChar
    calculate(resultString: resultString, result: &result, &calculateStatus)
}








func quickRemoveLast(_ resultString: String) -> String {
    let complexAlphabetRemove: [String] = ["log", "√(", "arcsin(", "arccos(", "arctan(", "sin(", "cos(", "tan(", " mod ", "(1|", "GCD(", "LCM(", "nCr(", "nPr(", "mean(", "max(", "min(", "median(", "randInt(", "randReal(", ", "]
    var str = resultString
    if removeSingleSuffix(&str, complexAlphabetRemove: complexAlphabetRemove) {
        return str
    }
    else {
        if !str.isEmpty {
            str.removeLast()
        }
    }
    return str
}

func backPressed(_ resultString: inout String,
                 _ result: inout String,
                 _ calculateStatus: inout Bool,
                 _ equalPressed: inout Bool,
                 _ powerNumberSymbol: inout Bool,
                 _ logNumberSymbol: inout Bool,
                 _ complexOperation: inout Bool,
                 _ complexParameter: inout Bool) -> Void {
    
    guard let firstLastCharacter = resultString.last else { return }
    
    if !resultString.isEmpty {
        if equalPressed {
            equalPressed = false
        }
        else if powerNumberSymbol && !containPowerNumber(resultString) {
            powerNumberSymbol = false
            complexOperation = false
        }
        else if logNumberSymbol && !containLogNumber(resultString) {
            logNumberSymbol = false
            complexOperation = false
        }
        else if !powerNumberSymbol && isPowerNumber(firstLastCharacter) {
            powerNumberSymbol = true
            complexOperation = true
        }
        else if !logNumberSymbol && isLogNumber(firstLastCharacter) {
            logNumberSymbol = true
            complexOperation = true
        }
        else {
            
            resultString = quickRemoveLast(resultString)
            
            if !resultString.isEmpty {
                guard let secondLastCharacter = resultString.last else { return }
                
                if !isPowerNumber(firstLastCharacter) && isPowerNumber(secondLastCharacter){
                    powerNumberSymbol = true
                    complexOperation = true
                }
                else if !isLogNumber(firstLastCharacter) && isLogNumber(secondLastCharacter) {
                    logNumberSymbol = true
                    complexOperation = true
                }
                calculate(resultString: resultString, result: &result, &calculateStatus)
            }
            else {
                result = ""
                complexOperation = false
                complexParameter = false
                powerNumberSymbol = false
                logNumberSymbol = false
            }
        }
    }
}








func trashPressed(_ resultString: inout String,
                  _ result: inout String,
                  _ equalPressedCheck: inout Bool,
                  _ complexOperation: inout Bool,
                  _ complexParameter: inout Bool,
                  _ powerNumberSymbol: inout Bool,
                  _ logNumberSymbol: inout Bool) -> Void {
    
    if !resultString.isEmpty {
        resultString.removeAll()
    }
    if !result.isEmpty {
        result.removeAll()
    }
    equalPressedCheck = false
    complexOperation = false
    complexParameter = false
    powerNumberSymbol = false
    logNumberSymbol = false
}






func equalPressed(_ resultString: inout String,
                  _ equalCheck: inout Bool,
                  _ calculateStatus: Bool,
                  _ powerNumberSymbol: inout Bool,
                  _ logNumberSymbol: inout Bool,
                  _ complexOperation: inout Bool,
                  _ complexParameter: inout Bool) -> Void {
    if calculateStatus && resultString != "" && !complexOperation { equalCheck = true }
    
    if resultString == "" {
        powerNumberSymbol = false
        logNumberSymbol = false
        complexOperation = false
        complexParameter = false
    }
    else {
        if powerNumberSymbol { powerNumberSymbol = false }
        
        if logNumberSymbol {
            logNumberSymbol = false
            guard let lastCharacter = resultString.last else { return }
            if !isLogNumber(lastCharacter) {
                resultString += "𝔢"
            }
        }
        
        if complexOperation { complexOperation = false }
        if complexParameter { complexParameter = false }
    }
}







func squarePressed(resultString: inout String,
                   _ result: inout String,
                   _ calculateStatus: inout Bool,
                   _ resultType: Int,
                   _ equalPressed: inout Bool) -> Void {
    
    if equalPressed {
        equalPressedSwitch(&resultString, result, resultType, &equalPressed)
    }
    resultString += "²"
    calculate(resultString: resultString, result: &result, &calculateStatus, squareCheck: true)
}






func powerPressed(_ resultString: inout String,
                  _ result: String,_ resultType: Int ,
                  _ complexOperation: inout Bool,
                  _ powerNumberSymbol: inout Bool,
                  _ equalPressed: inout Bool) -> Void {
    
    if equalPressed {
        equalPressedSwitch(&resultString, result, resultType, &equalPressed)
    }
    powerNumberSymbol = true
    complexOperation = true
}


func constantPowerPressed(_ constantBase: String,
                            _ resultString: inout String,
                            _ result: inout String,
                            _ calculateStatus: inout Bool,
                            _ resultType: Int,
                            _ complexOperation: inout Bool,
                            _ powerNumberSymbol: inout Bool,
                            _ equalPressed: inout Bool) -> Void {
    
    if equalPressed {
        equalPressedSwitch(&resultString, result, resultType, &equalPressed)
        resultString = String(resultString.map { char in
            return powerReplacements[char] ?? char
        })
        resultString = constantBase + resultString
        calculate(resultString: resultString, result: &result, &calculateStatus)
    }
    else {
        resultString += constantBase
        powerNumberSymbol = true
        complexOperation = true
    }
}


func enterExponentPressed(_ resultString: inout String,
                            _ result: String,
                            _ resultType: Int,
                            _ equalPressed: inout Bool) -> Void {
    
    if equalPressed {
        equalPressedSwitch(&resultString, result, resultType, &equalPressed)
        resultString += "𝐄"
    }
    else {
        resultString += "𝐄"
    }
}




func squareRootPressed(_ resultString: inout String,
                       _ result: String,
                       _ resultType: inout Int,
                       _ equalPressed: inout Bool) -> Void {
    
    if equalPressed {
        equalPressedSwitch(&resultString, result, resultType, &equalPressed)
        
        resultString = "√(" + resultString
    }
    else {
        resultString += "√("
    }
}





func factorialPressed(_ resultString: inout String,
                      _ result: inout String,
                      _ calculateStatus: inout Bool,
                      _ resultType: Int,
                      _ equalPressed: inout Bool) -> Void {
    
    if equalPressed {
        equalPressedSwitch(&resultString, result, resultType, &equalPressed)
    }
    resultString += "!"
    calculate(resultString: resultString, result: &result, &calculateStatus, squareCheck: true)
}





func logaritPressed(_ resultString: inout String,
                    _ result: inout String,
                    _ calculateStatus: inout Bool,
                    _ resultType: Int,
                    _ complexOperation: inout Bool,
                    _ logNumberSymbol: inout Bool,
                    _ equalPressed: inout Bool) -> Void {
    
    if equalPressed {
        equalPressedSwitch(&resultString, result, resultType, &equalPressed)
        
        resultString = "log𝔢" + resultString
        calculate(resultString: resultString, result: &result, &calculateStatus)
    }
    else {
        resultString += "log"
        logNumberSymbol = true
        complexOperation = true
    }
}






func moduloPressed( _ resultString: inout String,
                    _ result: inout String,
                    _ calculateStatus: inout Bool,
                    _ resultType: Int,
                    _ equalPressed: inout Bool) -> Void {
    if equalPressed {
        equalPressedSwitch(&resultString, result, resultType, &equalPressed)
        resultString += " mod "
    }
    else {
        resultString += " mod "
    }
    calculate(resultString: resultString, result: &result, &calculateStatus)
}



func SinCosTanPressed(_ ID: String,
                      _ resultString: inout String,
                      _ result: String,
                      _ resultType: Int,
                      _ equalPressed: inout Bool) -> Void {
    
    let suffix = ID
    
    if equalPressed {
        equalPressedSwitch(&resultString, result, resultType, &equalPressed)
        
        resultString = suffix + "(" + resultString
    }
    else {
        resultString += suffix + "("
    }
}



func oneDivideXPressed(_ resultString: inout String,
                       _ result: inout String,
                       _ resultType: Int,
                       _ calculateStatus: inout Bool,
                       _ equalPressed: inout Bool) -> Void {
    
    if equalPressed {
        equalPressedSwitch(&resultString, result, resultType, &equalPressed)
        resultString = "(1|" + resultString
    }
    else {
        resultString += "(1|"
    }
    calculate(resultString: resultString, result: &result, &calculateStatus)
}



func complexParameterFunctionPressed(_ functionID: String,
                    _ resultString: inout String,
                    _ result: String,
                    _ resultType: Int,
                    _ complexOperation: inout Bool,
                    _ complexParameter: inout Bool,
                    _ equalPressed: inout Bool) -> Void {
    
    if equalPressed {
        equalPressedSwitch(&resultString, result, resultType, &equalPressed)
        resultString = functionID + "(" + resultString
    }
    else {
        resultString += functionID + "("
    }
    complexOperation = true
    complexParameter = true
}



func randomPressed(_ resultString: inout String,
                   _ result: inout String,
                   _ calculateStatus: inout Bool,
                   _ powerNumberSymbol: Bool,
                   _ logNumberSymbol: Bool) -> Void {

    var randNum = String(random())
    randNum = removeSuffix(randNum, suffix: ".0")
    if logNumberSymbol {
        while(randNum == "1") {
            randNum = String(random(from: 0))
            randNum = removeSuffix(randNum, suffix: ".0")
        }
        randNum = String(randNum.map { char in
            return logReplacements[char] ?? char
        })
    }
    else if powerNumberSymbol {
        randNum = String(randNum.map { char in
            return powerReplacements[char] ?? char
        })
    }
    resultString += randNum

    calculate(resultString: resultString, result: &result, &calculateStatus)
}




func switchTypeForResultString(_ explicitResult: String, _ resultType: Int) -> String {
    var optionalResult: String = ""
    let maxDecimalDigits = calculateMaxDecimalDigits(for: Double(explicitResult.replacingOccurrences(of: ",", with: "")) ?? 0)
    
    switch resultType {
    case 1:
        optionalResult = expandRepeatingDecimal(explicitResult, maxDecimalDigits)
    case 2:
        optionalResult = expandRepeatingDecimal(explicitResult, maxDecimalDigits)
    case 3:
        optionalResult = expandRepeatingDecimal(explicitResult, maxDecimalDigits)
    case 4:
        optionalResult = floatToFraction(explicitResult, maxDecimalDigits)
    default:
        optionalResult = formatRepeatingDecimal(explicitResult, maxDecimalDigits)
    }
    
    return optionalResult
}


func equalPressedSwitch(_ resultString: inout String,
                        _ result: String,
                        _ resultType: Int,
                        _ equalPressedCheck: inout Bool) {
    resultString = "\(switchTypeForResultString(result, resultType).replacingOccurrences(of: ",", with: ""))"
    if resultString.contains("|") {resultString = "(" + resultString + ")"}
    equalPressedCheck = false
}

struct ButtonPressed_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}
