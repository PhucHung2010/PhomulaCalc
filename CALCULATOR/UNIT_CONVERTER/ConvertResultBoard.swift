//
//  ConvertResultBoard.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 16/10/2024.
//

import SwiftUI

struct ConvertResultBoard: View {
    var numString: String
    
    let THEME: ThemeStyle
    
    let widthNumber: CGFloat
    let heightNumber: CGFloat
    
   
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(THEME.Board_Color)
                .frame(width: widthNumber, height: heightNumber)
                .shadow(radius: 8)
                .overlay(
                    VStack {
                        ScrollView(.horizontal) {
                            ScrollViewReader { proxy in
                                HStack {
                                    Text("\(!numString.isEmpty ? numString : "0")")
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
                                                    .onChange(of: numString.count) { _ in
                                                        DispatchQueue.main.async {
                                                            scrollToEnd(proxy: proxy)
                                                        }
                                                    }
                                            }
                                        )
                                        .animation(.easeOut(duration: 0.1), value: numString)
                                }
                            }
                        }
                    }
                )
        }
    }
    
    

    private func scrollToEnd(proxy: ScrollViewProxy) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            withAnimation{
                proxy.scrollTo("scrollId", anchor: .trailing)
            }
        }
    }
}



//struct ConvertResultBoard_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        mainView(THEME: StyleChoices().lightTheme)
//    }
//}
