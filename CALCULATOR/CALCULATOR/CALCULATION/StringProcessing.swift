//
//  StringProcessing.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 31/08/2024.
//

import Foundation


func removeSingleSuffix(_ str: inout String, complexAlphabetRemove: [String]) -> Bool {
    for suffix in complexAlphabetRemove {
        if str.hasSuffix(suffix) {
            str = String(str.dropLast(suffix.count))
            return true
        }
    }
    return false
}

func removeSuffix(_ str: String, suffix: String) -> String {
    guard str.hasSuffix(suffix) else { return str }
    return String(str.dropLast(suffix.count))
}


func containsAnyAlphabet(_ input: String) -> Bool {
    // Tạo một tập hợp các chữ cái từ 'a' đến 'z'
    let alphabetSet: Set<Character> = Set("abcdefghijklmnopqrstuvwxyz")
    
    // Chuyển chuỗi đầu vào thành chữ thường và tạo một tập hợp chứa các ký tự từ chuỗi đó
    let inputSet: Set<Character> = Set(input.lowercased())
    
    // Kiểm tra xem tập hợp các ký tự chuỗi có chứa bất kỳ chữ cái nào không
    return !alphabetSet.isDisjoint(with: inputSet)
}




let replacePowerSymbol: [Character : Character] = ["¹" : "1", "²" : "2", "³" : "3", "⁴" : "4", "⁵" : "5", "⁶" : "6", "⁷" : "7", "⁸" : "8", "⁹" : "9", "⁰" : "0", "·" : ".", "ᵉ" : "𝐞", "π" : "𝝿", "⁽" : "(", "⁾" : ")", "⁺" : "+", "⁻" : "-", "ˣ" : "*", "#" : "/"]
let powerReplacements: [Character : Character] = ["1" : "¹", "2" : "²", "3" : "³", "4" : "⁴", "5" : "⁵", "6" : "⁶", "7" : "⁷", "8" : "⁸", "9" : "⁹", "0" : "⁰", "." : "·", "𝐞" : "ᵉ", "π" : "𝝿", "(" : "⁽", ")" : "⁾", "+" : "⁺", "-" : "⁻", "*" : "ˣ", "/" : "#"]

func isPowerNumber(_ char: Character) -> Bool {
    if char == "¹" ||  char == "²" || char == "³" || char == "⁴" || char == "⁵" || char == "⁶" || char == "⁷" || char == "⁸" || char == "⁹" || char == "⁰" || char == "ᵉ" || char == "π"{
        return true
    }
    return false
}


let replaceLog: [Character : Character] = ["₁" : "1", "₂" : "2", "₃" : "3", "₄" : "4", "₅" : "5", "₆" : "6", "₇" : "7", "₈" : "8", "₉" : "9", "₀" : "0" , "․" : ".", "𝔢" : "𝐞", "Π" : "𝝿"]
let logReplacements: [Character : Character] = ["1" : "₁", "2" : "₂", "3" : "₃", "4" : "₄", "5" : "₅", "6" : "₆", "7" : "₇", "8" : "₈", "9" : "₉", "0" : "₀", "." : "․"]
func isLogNumber(_ char: Character) -> Bool {
    
    if char == "₁" ||  char == "₂" || char == "₃" || char == "₄" || char == "₅" || char == "₆" || char == "₇" || char == "₈" || char == "₉" || char == "₀" || char == "𝔢" || char == "Π"{
        return true
    }
    return false
}


func isNumber(_ char: Character) -> Bool {
    if char == "1" ||  char == "2" || char == "3" || char == "4" || char == "5" || char == "6" || char == "7" || char == "8" || char == "9" || char == "0"{
        return true
    }
    return false
}

func containPowerNumber(_ resultString: String) -> Bool {
    for char in resultString {
        if isPowerNumber(char) {return true}
    }
    return false
}

func containLogNumber(_ resultString: String) -> Bool {
    for char in resultString {
        if isLogNumber(char) {return true}
    }
    return false
}



/// Replace constant symbol to constant
func replaceConstants(_ expression: String, _ calculateStatus: inout Bool) -> String {
    
    if !calculateStatus {calculateStatus = true}
    
    let targetConstant: Set<Character> = ["𝐞", "𝝿", "Φ", "ψ", "∁"]

    for index in expression.indices {
        let currentChar = expression[index]
        
        // Kiểm tra nếu ký tự hiện tại nằm trong tập mục tiêu
        if targetConstant.contains(currentChar) {
            // Kiểm tra ký tự phía trước, nếu có
            if index > expression.startIndex {
                let previousIndex = expression.index(before: index)
                if expression[previousIndex].isNumber {
                    calculateStatus = false
                }
            }
            
            // Kiểm tra ký tự phía sau, nếu có
            if index < expression.index(before: expression.endIndex) {
                let nextIndex = expression.index(after: index)
                if expression[nextIndex].isNumber {
                    calculateStatus = false
                }

            }
        }
    }
    
    if calculateStatus {
        var result = expression
        // Duyệt qua từng hằng số và thay thế trong chuỗi
        for (symbol, value) in constants {
            // Tạo chuỗi giá trị hằng số dưới dạng chuỗi
            let valueString = "\(value)"
            // Thay thế tất cả các symbol bằng giá trị tương ứng
            result = result.replacingOccurrences(of: symbol, with: valueString)
        }
        
        return result
    }
    
    return expression
}
