//
//  ExtraOperatorInformation.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 26/09/2024.
//

import SwiftUI

struct ExtraOperatorInformationSheet: View {
    
    let THEME: ThemeStyle
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 40) {
                        
                        Text("Mathematical Constants\n&Functions")
                            .font(.system(size: 30, weight: .heavy, design: .rounded))
                            .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                            .multilineTextAlignment(.center)

                        
                        
                        // Constants Section
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Constants")
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                                .padding(.horizontal)
                            
                            ForEach(mathConstants, id: \.name) { item in
                                NavigationLink(destination: FunctionDetailView(item: item, THEME: THEME, id: "Constants")) {
                                    HStack {
                                        Text(item.name)
                                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                                            .foregroundColor(THEME.ExtraOperatorInfor_title2CharacterColor)
                                            .padding()
                                        Spacer()
                                        Image(systemName: "arrowshape.turn.up.right.fill")
                                            .foregroundColor(THEME.ExtraOperatorInfor_title2CharacterColor)
                                            .padding()
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        LinearGradient(THEME.ExtraOperatorInfor_linkBackgroundStart, THEME.ExtraOperatorInfor_linkBackgroundEnd)
                                    )
                                    .cornerRadius(20)
                                    .shadow(color: THEME.ExtraOperatorInfor_linkShadow, radius: 1)
                                    .padding(.horizontal)
                                }
                            }
                        }
                        
                        // Functions Section
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Functions")
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                                .padding(.horizontal)
                            
                            ForEach(mathFunctions, id: \.name) { item in
                                NavigationLink(destination: FunctionDetailView(item: item, THEME: THEME, id: "Functions")) {
                                    HStack {
                                        Text(item.name)
                                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                                            .foregroundColor(THEME.ExtraOperatorInfor_title2CharacterColor)
                                            .padding()
                                        Spacer()
                                        Image(systemName: "arrowshape.turn.up.right.fill")
                                            .foregroundColor(THEME.ExtraOperatorInfor_title2CharacterColor)
                                            .padding()
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        LinearGradient(THEME.ExtraOperatorInfor_linkBackgroundStart, THEME.ExtraOperatorInfor_linkBackgroundEnd)
                                    )
                                    .cornerRadius(20)
                                    .shadow(color: THEME.ExtraOperatorInfor_linkShadow, radius: 1)
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding(.top, 50) // Tạo khoảng trống phía trên để tránh đụng vào cạnh trên của thiết bị
                }
            }
            .navigationBarHidden(true) // Ẩn thanh tiêu đề của NavigationView
        }
    }
}

struct FunctionDetailView: View {
    let item: MathFunctionConstant
    let THEME: ThemeStyle
    let id: String
    
    @Environment(\.presentationMode) var presentationMode // Để xử lý quay lại
    
    var body: some View {
        ZStack {
            LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text(item.name)
                        .font(.system(size: 35, weight: .heavy, design: .rounded))
                        .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                    
                    Text(item.description)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(THEME.ExtraOperatorInfor_bodyCharacterColor)
                        .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true) // Ẩn nút quay lại mặc định
        .navigationBarItems(leading: CustomBackButton(THEME: THEME, id: id)) // Sử dụng nút quay lại tùy chỉnh
    }
}


struct CustomBackButton: View {
    let THEME: ThemeStyle
    @Environment(\.presentationMode) var presentationMode
    let id: String
    
    var body: some View {
        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
            HStack {
                Image(systemName: "arrowshape.turn.up.left.fill") // Biểu tượng quay lại
                    .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Text("\(id)")
                    .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
            }
        }
        .buttonStyle(ScaledButtonStyle(scaleRadius: 1.5))
    }
}



// Dữ liệu mẫu cho constants và functions
let mathConstants: [MathFunctionConstant] = [
    MathFunctionConstant(name: "𝝿 (Pi)", description: "Pi (π) is the ratio of a circle's circumference to its diameter. It is an irrational number, approximately 3.14159.\n\nExample: The area of a circle is calculated as A = π * r²."),
    
    MathFunctionConstant(name: "𝐞 (Euler's Number)", description: "Euler's number (e) is the base of the natural logarithm and approximately equals 2.71828. It is used extensively in calculus, particularly in growth and decay models.\n\nExample: The exponential function f(x) = e^x grows faster than any polynomial function."),
    
    MathFunctionConstant(name: "Φ (Golden Ratio)", description: "The golden ratio is an irrational number, approximately 1.618, found by dividing a line into two parts so that the ratio of the longer part to the shorter part equals the ratio of the whole to the longer part.\n\nExample: The golden ratio is often seen in nature, architecture, and art, like the proportions of the Parthenon."),
    
    MathFunctionConstant(name: "Ψ (Fibonacci constant)", description: "The Fibonacci constant, also known as the Fibonacci reciprocal constant, denoted by ψ, is defined as the sum of the reciprocals of all Fibonacci numbers: The ratio between two consecutive terms in this sum will gradually approach the golden ratio."),
    
    
    MathFunctionConstant(name: "∁ (Speed of Light)", description: "The speed of light in a vacuum is approximately 299,792,458 meters per second. It is a fundamental constant in physics, often used in Einstein's equation E = mc².\n\nExample: Light takes about 8 minutes to travel from the Sun to Earth.")
]

let mathFunctions: [MathFunctionConstant] = [
    MathFunctionConstant(name: "Power, Sqrt", description: "The power function returns the result of a number raised to a given exponent. The square root returns the number that, when multiplied by itself, gives the original number.\n\nExample: 2^3 = 8, sqrt(9) = 3."),
    
    
    MathFunctionConstant(name: "Log", description: "The logarithm function returns the exponent by which a base number must be raised to produce a given number. Common logarithms include base 10 and base e (natural log).\n\nExample: log₁₀(100) = 2, ln(e) = 1."),
    
    
    MathFunctionConstant(name: "Factorial (!)", description: "The factorial of a non-negative integer n is the product of all positive integers less than or equal to n.\n\nExample: 5! = 5 * 4 * 3 * 2 * 1 = 120."),
    
    
    MathFunctionConstant(name: "Trigonometric Functions", description: "Cos, Sin, Tan, Arccos, Arcsin, Arctan\n\nThese functions represent the relationships between angles and sides of a right triangle. Inverse functions (arccos, arcsin, arctan) return the angles for given values.\n\nExample: sin(30°) = 0.5, cos(0°) = 1, tan(45°) = 1, arcsin(0.5) = 30°"),
    
    
    MathFunctionConstant(name: "Modulo", description: "The modulus function returns the remainder of a division of two numbers.\n\nExample: 7 mod 3 = 1."),
    
    
    MathFunctionConstant(name: "EE", description: "EE (Engineering Exponent), this function represents numbers in the form of scientific notation, commonly used in engineering to express very large or small numbers.\n\nExample: 3.4 x 10E5 = 3.4 x 100000 = 340000."),
    
    
    MathFunctionConstant(name: "GCD, LCM, nCr, nPr", description: "GCD (Greatest Common Divisor) returns the largest number that divides two or more numbers without a remainder.\n\nLCM (Least Common Multiple) returns the smallest multiple common to two or more numbers.\n\nnCr and nPr are combinations and permutations functions for counting selections and arrangements.\n\nGCD(12, 8) = 4, LCM(3, 5) = 15, 5C2 = 10, 5P2 = 20."),
    
    
    MathFunctionConstant(name: "Mean, Median, Max, Min", description: "Mean is the average of a set of numbers.\n\nMedian is the middle value in a sorted set of numbers.\n\nMax returns the largest value in a set.\n\nMin returns the smallest value in a set.\n\nExample: For the set {3, 1, 4, 1, 5}, the mean is 2.8, median is 3, max is 5, and min is 1."),
    
    
    MathFunctionConstant(name: "Random Functions", description: "Random, randEle, randInt, randReal\n\nRandom generates a random number.\n\nrandEle selects a random element from a list.\nrandInt generates a random integer in a specified range.\n\nrandReal generates a random real number in a specified range.\n\nExample: randInt(1, 100) might return 42, randReal(0, 1) might return 0.657.")
]

// Struct mẫu
struct MathFunctionConstant {
    let name: String
    let description: String
}







struct MathConstantSheet_Previews: PreviewProvider {
    static var previews: some View {
        ExtraOperatorInformationSheet(THEME: StyleChoices().lightTheme)
    }
}



