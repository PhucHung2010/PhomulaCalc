//
//  Function_Operator.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 17/09/2024.
//
import Expression
typealias Expression = NumericExpression
import Foundation
import UIKit
import Darwin


func power(base: Double, exponent: Double) -> Double {
    return pow(base, exponent)
}

func sqrt(value: Double) -> Double {
    return sqrt(value)
}


func factorial(_ n: Double) -> Double {
    if n < 0 {return 0}
    if n == 0 { return 1.0 }
    if n > Double(Int.max) {
        return Double.nan
    }
    return (1...Int(n)).reduce(1.0) { result, i in
        result * Double(i)
    }
    
}


func log(base: Double, value: Double) -> Double {
    let result = log(value) / log(base)
    let roundedResult = round(result)
    if abs(result - roundedResult) <= 1e-14 {
        return roundedResult
    }
    return result
}




class GlobalState_IsUsingRadian: ObservableObject {
    static let shared = GlobalState_IsUsingRadian() // Singleton

    @Published var globalVariable_isUsingRadian: Bool = false
    @Published var globalVariable_isAvailableOfTrigonometric: Bool = false
}




// Hàm tính sin của góc (đơn vị: độ)
func sinDegree(_ degree: Double) -> Double {
    let isUsingRadian = GlobalState_IsUsingRadian.shared.globalVariable_isUsingRadian
    
    if isUsingRadian {
        return sin(degree)
    }
    
    let radians = degree * .pi / 180
    let result = sin(radians)
    
    let roundedResult = round(result * 1e15) / 1e15

    if abs(result - roundedResult) <= 1e-15 {
        return roundedResult
    }
    return result
}

// Hàm tính sin⁻¹ của một giá trị (đơn vị: độ)
func arcsinDegree(_ value: Double) -> Double {
    
    let isUsingRadian = GlobalState_IsUsingRadian.shared.globalVariable_isUsingRadian
    
    if isUsingRadian {
        return asin(value)
    }
    
    let radians = asin(value)
    let degree = radians * 180 / .pi
    
    let roundedResult = round(degree * 1e13) / 1e13

    if abs(degree - roundedResult) <= 1e-13 {
        return roundedResult
    }
    return degree
}



// Hàm tính cos của góc (đơn vị: độ)
func cosDegree(_ degree: Double) -> Double {
    let isUsingRadian = GlobalState_IsUsingRadian.shared.globalVariable_isUsingRadian
    
    if isUsingRadian {
        return cos(degree)
    }
    
    let radians = degree * .pi / 180
    let result = cos(radians)
    
    let roundedResult = round(result * 1e15) / 1e15

    if abs(result - roundedResult) <= 1e-15 {
        return roundedResult
    }
    return result
}

// Hàm tính cos⁻¹ của một giá trị (đơn vị: độ)
func arccosDegree(_ value: Double) -> Double {
    let isUsingRadian = GlobalState_IsUsingRadian.shared.globalVariable_isUsingRadian
    
    if isUsingRadian {
        return acos(value)
    }
    
    let radians = acos(value)
    let degree = radians * 180 / .pi
    
    let roundedResult = round(degree * 1e13) / 1e13

    if abs(degree - roundedResult) <= 1e-13 {
        return roundedResult
    }
    return degree
}


// Hàm tính tan của góc (đơn vị: độ)
func tanDegree(_ degree: Double) -> Double {
    let isUsingRadian = GlobalState_IsUsingRadian.shared.globalVariable_isUsingRadian
    
    if isUsingRadian {
        return tan(degree)
    }
    
    let radians = degree * .pi / 180
    let result = tan(radians)
    
    let roundedResult = round(result * 1e15) / 1e15

    if abs(result - roundedResult) <= 1e-15 {
        return roundedResult
    }
    return result
}

// Hàm tính tan⁻¹ của một giá trị (đơn vị: độ)
func arctanDegree(_ value: Double) -> Double {
    let isUsingRadian = GlobalState_IsUsingRadian.shared.globalVariable_isUsingRadian
    
    if isUsingRadian {
        return atan(value)
    }
    
    let radians = atan(value)
    let degree = radians * 180 / .pi
    
    let roundedResult = round(degree * 1e13) / 1e13

    if abs(degree - roundedResult) <= 1e-13 {
        return roundedResult
    }
    return degree
}



func mod(_ a: Double, _ b: Double) -> Double {
    return a.truncatingRemainder(dividingBy: b)
}



func enterExponent(_ base: Double, _ exponent: Double) -> Double {
    return base * pow(10, exponent)
}



func greatestCommonDivisor(_ a: Double, _ b: Double) -> Double {
    var a = a
    var b = b
    while b != 0 {
        let temp = b
        b = a.truncatingRemainder(dividingBy: b)
        a = temp
    }
    return a
}

func leastCommonMultiple(_ a: Double, _ b: Double) -> Double {
    return abs(a * b) / greatestCommonDivisor(a, b)
}

func GCD(_ numbers: Double...) -> Double {
    return numbers.reduce(0) { greatestCommonDivisor($0, $1) }
}



func LCM(_ numbers: Double...) -> Double {
    return numbers.reduce(1) { leastCommonMultiple($0, $1) }
}



func nCr(_ n: Double, _ r: Double) -> Double {
    if r > n {return 0}
    return factorial(n) / (factorial(r) * factorial(n - r))
}

func nPr(_ n: Double, _ r: Double) -> Double {
    if r > n {return 0}
    return factorial(n) / factorial(n - r)
}


func randomReal(from a: Double, to b: Double) -> Double {
    let lowerBound = min(a, b)
    let upperBound = max(a, b)
    return Double.random(in: lowerBound...upperBound)
}


func randomInt(from a: Double, to b: Double) -> Double {
    let lowerBound = min(a, b)
    let upperBound = max(a, b)
    return Double(Int.random(in: Int(lowerBound)...Int(upperBound)))
}


func random(from a: Double = Double(-1e10), to b: Double = Double(1e10)) -> Double {
    let isInteger = Bool.random()
    if isInteger {
        return Double(Int.random(in: Int(a)...Int(b)))
    } else {
        return Double.random(in: a...b)
    }
}

func randomEle(_ arr: Double...) -> Double {
    return arr.randomElement() ?? 0
}




// Symbol for calculate function

let customSymbols: [Expression.Symbol: Expression.SymbolEvaluator] = [
    .infix("**"): { args in
        return power(base: args[0], exponent: args[1])
    },

    .postfix("!"): { args in
        return factorial(args[0])
    },
    
    .postfix("%"): { args in
        return args[0] / 100
    },
    
    .postfix("‰"): { args in
        return args[0] / 1000
    },
    
    .infix("log"): { args in
        return log(base: args[0], value: args[1])
    },
    
    .infix("mod"): { args in
        return mod(args[0], args[1])
    },
    
    .infix("𝐄"): {args in
        return enterExponent(args[0], args[1])
    },
    
    .function("sqrt", arity: 1): { args in
        return sqrt(value: args[0])
    },
    
    .function("sin", arity: 1): { args in
        return sinDegree(args[0])
    },
    
    .function("cos", arity: 1): { args in
        return cosDegree(args[0])
    },

    .function("tan", arity: 1): { args in
        return tanDegree(args[0])
    },
    .function("arcsin", arity: 1): { args in
        return arcsinDegree(args[0])
    },
    
    .function("arccos", arity: 1): { args in
        return arccosDegree(args[0])
    },

    .function("arctan", arity: 1): { args in
        return arctanDegree(args[0])
    },
    
    .function("GCD", arity: .any): { args in
        return args.reduce(0) { greatestCommonDivisor($0, $1) }
    },
    
    .function("LCM", arity: .any): { args in
        return args.reduce(1) { leastCommonMultiple($0, $1) }
    },
    
    .function("nCr", arity: 2): {args in
        return nCr(args[0], args[1])
    },
    
    .function("nPr", arity: 2): {args in
        return nPr(args[0], args[1])
    },
    
    .function("mean", arity: .any): { args in
        let sum = args.reduce(0) { $0 + $1 }
        return sum / Double(args.count)       
    },
    
    .function("max", arity: .any): { args in
        return args.max() ?? 0
    },
    
    .function("min", arity: .any): { args in
        return args.min() ?? 0 
    },
    
    .function("median", arity: .any): { args in
        let sorted = args.sorted()
        let mid = args.count / 2
        if args.count % 2 == 0 {
            return (sorted[mid - 1] + sorted[mid]) / 2
        } else {
            return sorted[mid]
            
        }
    },
    
    .function("random", arity: 0): {args in
        return random()
    },
    
    .function("randInt", arity: 2): {args in
        return randomInt(from: args[0], to: args[1])
    },
    
    .function("randReal", arity: 2): {args in
        return randomReal(from: args[0], to: args[1])
    },
    
    .function("randEle", arity: .any): { args in
        return args.randomElement() ?? random()
    }
    
]


// CONSTANT
let constants: [String : String] = [
    "𝝿": String(Double.pi),
    "𝐞": String(exp(1.0)),
    "Φ": "1.618033988749895",
    "ψ": "3.359885666243177",
    "∁": "299792458",
//    "%": "/100",
//    "‰": "/1000"
]
