//
//  Symbol_number.swift
//  CALCULATOR
//
//  Created by Hung Nguyen on 14/08/2024.
//

import SwiftUI

struct Symbol: View {
    var symbol : String
    var symbolColor: Color
    var symbolSize: CGFloat
    var boldFontWeight: Bool

    init(_ symbol: String, symbolColor: Color = .gray, symbolSize: CGFloat = 45, boldFontWeight: Bool = false) {
        self.symbol = symbol
        self.symbolColor = symbolColor
        self.symbolSize = symbolSize
        self.boldFontWeight = boldFontWeight
    }
    var body: some View {
        Image(systemName: "\(symbol)")
            .foregroundColor(symbolColor)
            .font(.system(size: symbolSize, weight: boldFontWeight ? .semibold : .regular, design: .rounded))
            .frame(width: 15, height: 10)
    }
}

struct Number: View {
    var number : String
    var numberColor: Color
    var fontWeight: Font.Weight
    var fontSize: CGFloat

    init(_ number: String, numberColor: Color = .gray, fontWeight: Font.Weight = .bold, fontSize: CGFloat = 45) {
        self.number = number
        self.numberColor = numberColor
        self.fontWeight = fontWeight
        self.fontSize = fontSize
    }
    
    var body: some View {
        Text("\(number)")
            .foregroundColor(numberColor)
            .fontWeight(fontWeight)
            .font(.system(size: fontSize, design: .rounded))
    }
}


// CUSTOM SYMBOL

struct xPowySymbol: View {
    var numberColor: Color
    var fontWeight: Font.Weight
    var fontSize: CGFloat
    var baseLetter: String
    var exponentLetter: String
    var exponentFontSize: CGFloat
    
    init(baseLetter: String = "x", exponentLetter: String = "y", numberColor: Color, fontWeight: Font.Weight = .semibold, fontSize: CGFloat = 25, exponentFontSize: CGFloat = 15) {
        self.baseLetter = baseLetter
        self.exponentLetter = exponentLetter
        self.numberColor = numberColor
        self.fontWeight = fontWeight
        self.fontSize = fontSize
        self.exponentFontSize = exponentFontSize
    }
    
    var body: some View {
        HStack (spacing: 1){
            Text("\(baseLetter)")
                .foregroundColor(numberColor)
                .fontWeight(fontWeight)
                .font(.system(size: fontSize, design: .rounded))
            
            VStack {
                Text("\(exponentLetter)")
                    .foregroundColor(numberColor)
                    .fontWeight(fontWeight)
                    .font(.system(size: exponentFontSize, design: .rounded))
                Spacer().frame(height: 13)
            }
                
        }
        
    }
}

struct RootNSymbol: View {
    var numberColor: Color = .gray
    var fontWeight: Font.Weight = .semibold
    var fontSize: CGFloat = 25
    
    var body: some View {
        HStack {
            VStack {
                Text("n")
                    .foregroundColor(numberColor)
                    .fontWeight(fontWeight)
                    .font(.system(size: 15))
                Spacer().frame(height: 10)
            }
            Spacer().frame(width: 0)
            
            VStack {
                Text("√")
                    .foregroundColor(numberColor)
                    .fontWeight(fontWeight)
                    .font(.system(size: fontSize))
            }
        }
        
    }
}

struct Symbol_number_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}





