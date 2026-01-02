//
//  TransformExpressionForPower.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 01/09/2024.
//


import Foundation

// MARK: - Token
enum Token: Equatable {
    case number(Double)
    case operatorSymbol(String)
    case leftParen
    case rightParen
}

// MARK: - Lexer
class Lexer {
    let input: String
    var currentIndex: String.Index

    init(input: String) {
        self.input = input.replacingOccurrences(of: " ", with: "") // Loại bỏ khoảng trắng
        self.currentIndex = self.input.startIndex
    }

    func getNextToken() -> Token? {
        guard currentIndex < input.endIndex else { return nil }

        let currentChar = input[currentIndex]

        // Xử lý số
        if currentChar.isNumber || currentChar == "." {
            var numberString = ""
            while currentIndex < input.endIndex && (input[currentIndex].isNumber || input[currentIndex] == ".") {
                numberString.append(input[currentIndex])
                currentIndex = input.index(after: currentIndex)
            }
            if let numberValue = Double(numberString) {
                return Token.number(numberValue)
            } else {
                return nil
            }
        }

        // Xử lý dấu ngoặc
        if currentChar == "(" {
            currentIndex = input.index(after: currentIndex)
            return Token.leftParen
        }

        if currentChar == ")" {
            currentIndex = input.index(after: currentIndex)
            return Token.rightParen
        }

        // Xử lý toán tử
        let operators = ["**", "𝐄", "+", "-", "*", "/", "!", "log", "mod", "%", "‰"]
        for op in operators.sorted(by: { $0.count > $1.count }) { // Kiểm tra toán tử dài trước
            if input[currentIndex...].starts(with: op) {
                currentIndex = input.index(currentIndex, offsetBy: op.count)
                return Token.operatorSymbol(op)
            }
        }

        // Nếu gặp ký tự không hợp lệ
        return nil
    }

    func tokenize() -> [Token] {
        var tokens: [Token] = []
        while let token = getNextToken() {
            tokens.append(token)
        }
        return tokens
    }
}

// MARK: - AST Nodes
indirect enum ASTNode {
    case number(Double)
    case binaryOperation(op: String, left: ASTNode, right: ASTNode)
    case expression(ASTNode)
}

// MARK: - Parser
class Parser {
    let tokens: [Token]
    var currentIndex = 0

    init(tokens: [Token]) {
        self.tokens = tokens
    }

    func parse() -> ASTNode? {
        return parseExpression()
    }

    // Thứ tự ưu tiên cho log
    private func parseLog() -> ASTNode? {
        guard var left = parsePrimary() else { return nil }

        while currentIndex < tokens.count {
            if case .operatorSymbol("log") = tokens[currentIndex] {
                currentIndex += 1
                guard let right = parsePrimary() else { return nil }
                left = .binaryOperation(op: "log", left: left, right: right)
            } else {
                break
            }
        }

        return left
    }

    // Hàm xử lý giai thừa
    private func parseFactorial(_ node: ASTNode) -> ASTNode {
        // Kiểm tra nếu token tiếp theo là '!'
        if currentIndex < tokens.count, case .operatorSymbol("!") = tokens[currentIndex] {
            currentIndex += 1
            return .binaryOperation(op: "!", left: node, right: .number(1)) // Giai thừa chỉ áp dụng lên một số nên right có thể là placeholder
        }
        else if currentIndex < tokens.count, case .operatorSymbol("%") = tokens[currentIndex] {
            currentIndex += 1
            return .binaryOperation(op: "%", left: node, right: .number(1)) // Giai thừa chỉ áp dụng lên một số nên right có thể là placeholder
        }
        else if currentIndex < tokens.count, case .operatorSymbol("‰") = tokens[currentIndex] {
            currentIndex += 1
            return .binaryOperation(op: "‰", left: node, right: .number(1)) // Giai thừa chỉ áp dụng lên một số nên right có thể là placeholder
        }
        return node
    }

    // Thứ tự ưu tiên cho lũy thừa (**)
    private func parseExponent() -> ASTNode? {
        guard var left = parseLog() else { return nil }

        while currentIndex < tokens.count {
            if case .operatorSymbol(let op) = tokens[currentIndex], op == "**" || op == "𝐄" {
                currentIndex += 1
                guard let right = parseExponent() else { return nil }
                left = .binaryOperation(op: op, left: left, right: right)
            } else {
                break
            }
        }

        return left
    }

    // Thứ tự ưu tiên cho nhân (*) và chia (/)
    private func parseTerm() -> ASTNode? {
        guard var left = parseExponent() else { return nil }

        while currentIndex < tokens.count {
            if case .operatorSymbol(let op) = tokens[currentIndex], op == "*" || op == "/" || op == "mod" {
                currentIndex += 1
                guard let right = parseExponent() else { return nil }
                left = .binaryOperation(op: op, left: left, right: right)
            } else {
                break
            }
        }

        return left
    }

    // Thứ tự ưu tiên cho cộng (+) và trừ (-)
    private func parseExpression() -> ASTNode? {
        guard var left = parseTerm() else { return nil }

        while currentIndex < tokens.count {
            if case .operatorSymbol(let op) = tokens[currentIndex], op == "+" || op == "-" {
                currentIndex += 1
                guard let right = parseTerm() else { return nil }
                left = .binaryOperation(op: op, left: left, right: right)
            } else {
                break
            }
        }

        return left
    }

    // Cập nhật hàm parsePrimary để xử lý log
    private func parsePrimary() -> ASTNode? {
        guard currentIndex < tokens.count else { return nil }
        let token = tokens[currentIndex]
        currentIndex += 1

        switch token {
        case .number(let value):
            return parseFactorial(.number(value)) // Kiểm tra xem có giai thừa không
        case .leftParen:
            if let expr = parseExpression() {
                if currentIndex < tokens.count && tokens[currentIndex] == .rightParen {
                    currentIndex += 1
                    return parseFactorial(.expression(expr)) // Kiểm tra xem có giai thừa không
                } else {
                    return nil
                }
            } else {
                return nil
            }
        default:
            return nil
        }
    }
}

// MARK: - AST to Expression String with Parentheses
class ASTPrinter {
    func printNode(_ node: ASTNode) -> String {
        switch node {
        case .number(let value):
            if value.truncatingRemainder(dividingBy: 1) == 0 {
                if value <= Double(Int.max) && value >= Double(Int.min) {
                    return "\(Int(value))"
                } else {
                    return "\(value)"
                }
            } else {
                return "\(value)"
            }
        case .expression(let expr):
            return "(\(printNode(expr)))"
        case .binaryOperation(let op, let left, let right):
            if op == "!" {
                return "\(printNode(left))!"
            }
            else if op == "%" {
                return "\(printNode(left))%"
            }
            else if op == "‰" {
                return "\(printNode(left))‰"
            }
            switch op {
            case "**", "𝐄":
                return "(\(printNode(left)) \(op) \(printNode(right)))"
            case "log":
                return "(\(printNode(left)) \(op) \(printNode(right)))"
            case "*", "/", "mod":
                return "\(printNode(left)) \(op) \(printNode(right))"
            case "+", "-":
                return "\(printNode(left)) \(op) \(printNode(right))"
            default:
                return ""
            }
        }
    }
}

// MARK: - Main Function
func OperatorPrecedence(_ expression: String) -> String {
    let lexer = Lexer(input: expression)
    let tokens = lexer.tokenize()

    let parser = Parser(tokens: tokens)
    guard let ast = parser.parse() else {
        return expression
    }

    let printer = ASTPrinter()
    let result = printer.printNode(ast)

    return result
}

