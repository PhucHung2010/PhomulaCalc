//
//  ResultType.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 03/09/2024.
//

import Foundation



// Nén phần thập phân tuần hoàn
func formatRepeatingDecimal(_ decimalString: String, _ maxDecimalDigits: Int) -> String {
    // Tách phần nguyên và phần thập phân
    guard let dotIndex = decimalString.firstIndex(of: ".") else {
        return decimalString
    }

    let integerPart = String(decimalString[..<dotIndex])
    let decimalPart = String(decimalString[decimalString.index(after: dotIndex)...])

    // Chỉ xử lý nếu phần thập phân có đúng maxDecimalDigits chữ số
    guard (decimalPart.count == maxDecimalDigits) || (decimalPart.count >= (maxDecimalDigits - 3)) else {
        return decimalString
    }

    // Hàm kiểm tra chu kỳ lặp từ vị trí bắt đầu xác định
    func findRepeatingSequence(_ decimalPart: String, startIndex: Int, maxCheckLength: Int) -> (String, String)? {
        let decimalSubstring = String(decimalPart.dropFirst(startIndex))
        let length = decimalSubstring.count

        guard length > 3 else {
           return nil
        }

        for l in 1...min(length / 2, maxCheckLength) {
            let repeatingSequence = String(decimalSubstring.prefix(l))
            var isRepeating = true

            for i in stride(from: l, to: length, by: l) {
                let start = decimalSubstring.index(decimalSubstring.startIndex, offsetBy: i)
                let end = decimalSubstring.index(start, offsetBy: min(l, decimalSubstring.distance(from: start, to: decimalSubstring.endIndex)))
                let nextSequence = String(decimalSubstring[start..<end])

                if nextSequence != repeatingSequence {
                    isRepeating = false
                    break
                }
            }

            if isRepeating {
                let nonRepeatingPart = String(decimalPart.prefix(startIndex))
                return (nonRepeatingPart, repeatingSequence)
            }
        }
        return nil
    }

    // Kiểm tra lần lượt với toàn bộ phần thập phân, sau đó giảm dần 1 và 2 chữ số cuối cùng
    let checkLengths = [maxDecimalDigits, maxDecimalDigits - 1, maxDecimalDigits - 2, maxDecimalDigits - 3]

    for startIndex in 0..<decimalPart.count {
        for checkLength in checkLengths where checkLength > 0 {
            if let (nonRepeatingPart, repeatingSequence) = findRepeatingSequence(String(decimalPart.prefix(checkLength)), startIndex: startIndex, maxCheckLength: checkLength) {
                if nonRepeatingPart.isEmpty {
                    return "\(integerPart).(\(repeatingSequence))"
                } else {
                    return "\(integerPart).\(nonRepeatingPart)(\(repeatingSequence))"
                }
            }
        }
    }

    return decimalString
}









// Giải nén phần thập phân tuần hoàn
func expandRepeatingDecimal(_ compressedString: String, _ maxDecimalDigits: Int) -> String {
    // Tìm vị trí của dấu '.' và '(' trong chuỗi
    guard let dotIndex = compressedString.firstIndex(of: "."),
          let openParenIndex = compressedString.firstIndex(of: "("),
          let closeParenIndex = compressedString.firstIndex(of: ")") else {
        // Nếu chuỗi không chứa phần tuần hoàn, trả về chuỗi gốc
        return compressedString
    }
    
    let integerPart = String(compressedString[..<dotIndex])
    let nonRepeatingPart = String(compressedString[compressedString.index(after: dotIndex)..<openParenIndex])
    let repeatingPart = String(compressedString[compressedString.index(after: openParenIndex)..<closeParenIndex])
    
    
    var expandedDecimal = nonRepeatingPart
    while expandedDecimal.count < maxDecimalDigits {
        expandedDecimal += repeatingPart
    }
    
    
    expandedDecimal = String(expandedDecimal.prefix(maxDecimalDigits))
    
    return "\(integerPart).\(expandedDecimal)"
}












// Phân số

func detectRepeatingDecimal(_ number: Double, _ maxDecimalDigits: Int) -> (numerator: Int64, denominator: Int64)? {
    let str = String(format: "%.\(maxDecimalDigits)f", number).split(separator: ".").last ?? ""

    // Hàm tìm chuỗi lặp
    func findRepeatingSequence(_ decimalPart: String, startIndex: Int, maxCheckLength: Int) -> (nonRepeatingPart: String, repeatingSequence: String)? {
        let decimalSubstring = String(decimalPart.dropFirst(startIndex))
        guard decimalSubstring.count > 3 else {
            return nil
        }

        for length in 1...(decimalSubstring.count / 2) {
            let repeatingSequence = String(decimalSubstring.prefix(length))
            var isRepeating = true

            for i in stride(from: length, to: decimalSubstring.count, by: length) {
                let start = decimalSubstring.index(decimalSubstring.startIndex, offsetBy: i)
                let end = decimalSubstring.index(start, offsetBy: min(length, decimalSubstring.distance(from: start, to: decimalSubstring.endIndex)))
                let nextSequence = String(decimalSubstring[start..<end])

                if nextSequence != repeatingSequence {
                    isRepeating = false
                    break
                }
            }

            if isRepeating {
                let nonRepeatingPart = String(decimalPart.prefix(startIndex))
                return (nonRepeatingPart, repeatingSequence)
            }
        }
        return nil
    }

    // Duyệt qua toàn bộ phần thập phân, giảm dần độ dài kiểm tra
    let checkLengths = [maxDecimalDigits, maxDecimalDigits - 1, maxDecimalDigits - 2, maxDecimalDigits - 3]

    for startIndex in 0..<str.count {
        for checkLength in checkLengths {
            // Kiểm tra nếu checkLength hợp lệ
            if checkLength > 0 && checkLength <= str.count {
                if let (nonRepeatingPart, repeatingSequence) = findRepeatingSequence(String(str.prefix(checkLength)), startIndex: startIndex, maxCheckLength: checkLength) {
                    // Tính tử số và mẫu số dựa trên phần không lặp và phần lặp
                    let nonRepeatingNumerator = Int64(nonRepeatingPart) ?? 0
                    let repeatingNumerator = Int64(repeatingSequence) ?? 0
                    
                    let nonRepeatingDenominator = Int64(pow(10.0, Double(nonRepeatingPart.count)))
                    let repeatingDenominator = Int64(pow(10.0, Double(repeatingSequence.count))) - 1

                    // Kiểm tra tràn số
                    if nonRepeatingDenominator > Int64.max / repeatingDenominator || repeatingNumerator > Int64.max / repeatingDenominator {
                        return nil // Tránh tràn số
                    }

                    // Tổng kết lại phân số
                    let numerator = nonRepeatingNumerator * repeatingDenominator + repeatingNumerator
                    let denominator = nonRepeatingDenominator * repeatingDenominator

                    return (numerator, denominator)
                }
            }
        }
    }

    return nil
}




func floatToFraction(_ numberStr: String, _ maxDecimalDigits: Int) -> String {
    let explicitNum = numberStr.replacingOccurrences(of: ",", with: "")
    guard let number = Double(explicitNum) else {
        return "" // Trả về chuỗi rỗng cho đầu vào không hợp lệ
    }

    let intPartDouble = floor(number) // Phần nguyên dưới dạng Double
    let fractionalPart = number - intPartDouble // Phần thập phân

    // Kiểm tra nếu đó là số nguyên
    if fractionalPart == 0 {
        // Kiểm tra nếu phần nguyên vượt quá Int64
        if intPartDouble > Double(Int64.max) {
//            calculateStatus = false
            return "∞" // Trả về lỗi nếu vượt quá giới hạn
        }
        let intPart = Int64(intPartDouble)
        return "\(intPart)|1" // Trả về phân số nếu số là nguyên
    }

    // Kiểm tra số chữ số thập phân
    let fractionalString = String(format: "%.\(maxDecimalDigits)f", fractionalPart).split(separator: ".").last ?? ""
    let fractionalLength = fractionalString.count
    
    if fractionalLength == maxDecimalDigits {
        // Kiểm tra phần thập phân lặp lại
        if let repeatingDecimal = detectRepeatingDecimal(fractionalPart, maxDecimalDigits) {
            // Tính tử số và mẫu số từ phần nguyên và phần thập phân lặp lại
            let repeatingDenominator = repeatingDecimal.denominator
            let repeatingNumerator = repeatingDecimal.numerator + Int64(intPartDouble) * repeatingDenominator
            
            let gcdValue = gcd(repeatingNumerator, repeatingDenominator)
            return "\(repeatingNumerator / gcdValue)|\(repeatingDenominator / gcdValue)"
        }
    }

    // Xử lý số thập phân hữu hạn không lặp lại
    let precision = maxDecimalDigits
    let factor = pow(10.0, Double(precision))
    let fractionalNumerator = Int64(round(fractionalPart * factor))
    let denominator = Int64(factor)

    // Tính tử số cho phần nguyên + phần thập phân
    let numerator = Int64(intPartDouble) * denominator + fractionalNumerator
    let gcdValue = gcd(numerator, denominator)

    return "\(numerator / gcdValue)|\(denominator / gcdValue)"
}

func gcd(_ a: Int64, _ b: Int64) -> Int64 {
    var a = a
    var b = b
    while b != 0 {
        let temp = b
        b = a % b
        a = temp
    }
    return a
}

















// Định dạng kết quả

func numberFormattedForResult(maxDecimalDigit: Int) -> NumberFormatter {
    let number = NumberFormatter()
//    number.numberStyle = .spellOut
    number.locale = Locale(identifier: "en_US")
    number.numberStyle = .decimal
    number.maximumFractionDigits = maxDecimalDigit
    number.minimumFractionDigits = 0
    number.roundingMode = .down
    return number
}



func integralDigitCount(_ expressionResult: String) -> Int {
    let formatString = String(format: "%.14f", expressionResult)
    let components = formatString.split(separator: ".")
    let integralPart = components.first ?? ""
    let integralDigits = integralPart.count
    return integralDigits
}




func calculateMaxDecimalDigits(for value: Double, maxDigits: Int = 14) -> Int {
    // Kiểm tra giá trị nếu nó bằng 0 hoặc rất nhỏ
    guard value != 0 else {
        return maxDigits
    }

    // Chuyển đổi giá trị thành chuỗi với định dạng chuẩn
    let formatString = String(format: "%.\(maxDigits)f", value)
    let components = formatString.split(separator: ".")
    let integralPart = components.first ?? ""

    // Đếm số chữ số phần nguyên
    let integralDigits = integralPart.count

    // Tính số chữ số thập phân tối đa
    return max(0, maxDigits - integralDigits)
}
