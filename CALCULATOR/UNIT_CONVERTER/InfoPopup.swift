//
//  InfoPopup.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 16/10/2024.
//

import SwiftUI

struct InfoPopup: View {
    @Binding var showPopup: Bool
    var category: Category
    var THEME: ThemeStyle
    
    var body: some View {
        ZStack {
            
//            if showPopup {
//                BlurView(style: .systemUltraThinMaterialDark)
//                    .ignoresSafeArea()
//                    .onTapGesture {
//                        withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.6, blendDuration: 0.1)) {
//                            showPopup = false
//                        }
//                    }
//                    .transition(.opacity)
//            }
            
            if showPopup {
                
                VStack {
                    ScrollView (showsIndicators: false){
                        VStack {
                            Spacer()
                            
                            Image(systemName: "\(CategoryManager.getIcon(category: category))")
                                .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                                .font(.system(size: 30))
                                
                            
                            Text(CategoryManager.getInfo(categoty: category))
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundColor(THEME.ExtraOperatorInfor_bodyCharacterColor)
                                .lineSpacing(15)
                                .padding(.horizontal)
                            
                            Spacer().frame(height: 20)
                        }
                    }
                }
                .padding()
                .background(
                    THEME.Board_Color
                        .ignoresSafeArea()
                        .cornerRadius(30)
                        .shadow(radius: 7)
                        .padding()
                )
                .transition(.scale.combined(with: .offset(y: 300)))
                
            }
            
        }
    }
}


struct InfoPopup_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}
