//
//  Calculate.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 30/08/2024.
//

import Foundation
import SwiftUI
import UIKit
import Darwin
import Expression



// Transform special symbol
/// Power
func powerTransformedExpression(_ expressionString: inout String) -> Void {
    
    var powExpression: String = ""
    var firstTimePlus: Bool = true
    var firstTimePlusChanged: Bool = false
    
    for char in expressionString {
        if isPowerNumber(char) || char == "·" || char == "⁽" || char == "⁾" || char == "⁺" || char == "⁻" || char == "ˣ" || char == "#" {
            if firstTimePlus {
                powExpression += "**("
                firstTimePlus = false
                firstTimePlusChanged = true
            }
        }
        else if !firstTimePlus {
            powExpression += ")"
            firstTimePlus = true
        }
        powExpression += String(char)
    }
    
    if !firstTimePlus && firstTimePlusChanged {powExpression += ")"}
    
    expressionString = String(powExpression.map { char in
        return replacePowerSymbol[char] ?? char
    })
}



/// Square
func squareTransformedExpression(_ expressionString: inout String, _ squareCheck: Bool) -> Void {
    if squareCheck {
        expressionString = expressionString.replacingOccurrences(of: "²", with: "**2")
    }
}



/// SquareRoot
func squareRootTransformedExpression(_ expressionString: inout String) -> Void {
    expressionString = expressionString.replacingOccurrences(of: "√", with: "sqrt")
}



/// Logarit
func logTransformedExpression(_ expressionString: inout String) -> Void {

    var powExpression: String = ""
    var firstTimePlus: Bool = true
    var firstTimePlusChanged: Bool = false

    for char in expressionString {
        if isLogNumber(char) || char == "․" {
            if firstTimePlus {
                powExpression += "("
                firstTimePlus = false
                firstTimePlusChanged = true
            }
        }
        else if !firstTimePlus {
            powExpression += ")"
            firstTimePlus = true
        }
        powExpression += String(char)
    }

    if !firstTimePlus && firstTimePlusChanged {powExpression += ")"}

    expressionString = String(powExpression.map { char in
        return replaceLog[char] ?? char
    })
}

func convertLogExpression(_ expression: String) -> String {
    var formattedExpression = expression
    
    // Tìm tất cả các biểu thức log(base) trong chuỗi, cho phép khoảng trống giữa log và (
    let pattern = "log\\s*\\(([^)]+)\\)"
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    
    let matches = regex.matches(in: expression, options: [], range: NSRange(location: 0, length: expression.utf16.count))

    for match in matches.reversed() {
        if let baseRange = Range(match.range(at: 1), in: expression) {
            let base = expression[baseRange]
            
            // Xóa chữ "log" và di chuyển nó sau (base)
            if let fullRange = Range(match.range, in: expression) {
                let replacement = "(\(base)) log "
                formattedExpression.replaceSubrange(fullRange, with: replacement)
            }
        }
    }

    return formattedExpression
}





/// Transform Function
func transformSpecialSymbolExpression(_ resultString: String, _ squareCheck: Bool, _ calculateStatus: inout Bool) -> String {
    
    let replacements: [Character : Character] = ["×" : "*", "÷" : "/", "−" : "-", "|" : "/"]
    var expressionString = String(resultString.map { char in
        return replacements[char] ?? char
    })
    
    // power transform
    powerTransformedExpression(&expressionString)
    // log transform
    logTransformedExpression(&expressionString)
    expressionString = convertLogExpression(expressionString)
    // square transform
    squareTransformedExpression(&expressionString, squareCheck)
    // squareroot transform
    squareRootTransformedExpression(&expressionString)
    
    // replace constant
    expressionString = replaceConstants(expressionString, &calculateStatus)

    // case: last character == function operator
    if let lastCharacter = expressionString.last {
        let character = String(lastCharacter)
        if character == "+" || character == "-" || character == "." {
            expressionString += "0"
        }
        else if character == "*" || character == "/" {
            expressionString += "1"
        }
    }
    
    if let firtCharacter = expressionString.first {
        let character = String(firtCharacter)
        if character == "+" {expressionString = "0" + expressionString}
    }
    
    return expressionString
}







// Execute Calculation
func calculate(resultString: String, result: inout String, _ calculateStatus: inout Bool, squareCheck: Bool = false) -> Void {
    
    if !GuardingBeforeCalculate(expression: resultString) {
        calculateStatus = false
        return
    }
    

    
    
    // Chuyển đổi ký hiệu đặt biệt
    var expressionString = transformSpecialSymbolExpression(resultString, squareCheck, &calculateStatus)
    
    
    // Độ ưu tiên phép toán
    expressionString = OperatorPrecedence(expressionString)
  
    
    let expression = Expression(expressionString, options: [], symbols: customSymbols)
    
    
    
    
    
    if resultString.contains("sin") || resultString.contains("cos") || resultString.contains("tan") || resultString.contains("arcsin") || resultString.contains("arccos") || resultString.contains("arctan") {
        GlobalState_IsUsingRadian.shared.globalVariable_isAvailableOfTrigonometric = true
    }
    else {
        GlobalState_IsUsingRadian.shared.globalVariable_isAvailableOfTrigonometric = false
    }
    
    
    
    if calculateStatus {
        do {
            let expressionResult = try expression.evaluate()


            // Tính số chữ số nguyên và số chữ số thập phân tối đa
            let maxDecimalDigits = calculateMaxDecimalDigits(for: expressionResult)
            
            // Đặt số chữ số thập phân tối đa và định dạng kết quả
            let numberFormatter = numberFormattedForResult(maxDecimalDigit: maxDecimalDigits)

            
            if let formattedResult = numberFormatter.string(from: NSNumber(value: expressionResult)) {
                result = formattedResult
            }
            
            calculateStatus = true
            
            if result == "-0" {
                result = "0"
            }
            
            if result == "NaN" {
                result = ""
                calculateStatus = false
            }
        } catch {
            calculateStatus = false
        }
    }
}



func GuardingBeforeCalculate(expression: String) -> Bool {
    let exceptionalCaculationCase = ["××"]
    
    for exceptionalCase in exceptionalCaculationCase {
        if expression.contains(exceptionalCase) {
            return false
        }
    }
    
    return true
}




struct SourceFunc_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}
