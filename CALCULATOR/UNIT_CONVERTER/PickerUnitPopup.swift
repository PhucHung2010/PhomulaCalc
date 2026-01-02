//
//  PickerUnitPopup.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 15/10/2024.
//

import SwiftUI

struct PickerUnitPopup: View {
    @ObservedObject var viewModel: DetailViewModel
    @Binding var viewModelOrder: Int
    
    
    let THEME: ThemeStyle
    
    var body: some View {
        ZStack {
//            if showPopup {
//                Color.black.opacity(0.2)
//                    .ignoresSafeArea()
//                    .onTapGesture {
//                        showPopup = false
//                    }
//                    .transition(.opacity)
//            }

            
            if viewModelOrder != 0 {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(0 ..< viewModel.units.count, id: \.self) { index in
                            
                            HStack {
                                Button(action: {
                                    if viewModelOrder == 1 {
                                        viewModel.firstUnit = index
                                    }
                                    else {
                                        viewModel.secondUnit = index
                                    }
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        viewModelOrder = 0
                                    }
                                }) {
                                    Text("\(viewModel.units[index].symbol)")
                                        .font(.system(.title2, design: .rounded))
                                        .fontWeight(.semibold)
                                        .foregroundColor(THEME.Board_resultStringColor)
                                }
                                .buttonStyle(ScaledButtonStyle(scaleRadius: 2.5))
                                
                                if viewModelOrder == 1 {
                                    if viewModel.units[viewModel.firstUnit].symbol == viewModel.units[index].symbol {
                                        Image(systemName: "checkmark")
                                            .font(.system(.title2, design: .rounded))
                                            .foregroundColor(THEME.Board_resultStringColor)
                                    }
                                }
                                else {
                                    if viewModel.units[viewModel.secondUnit].symbol == viewModel.units[index].symbol {
                                        Image(systemName: "checkmark")
                                            .font(.system(.title2, design: .rounded))
                                            .foregroundColor(THEME.Board_resultStringColor)
                                    }
                                }
                            }
                            
                            
                            if index < viewModel.units.count - 1 {
                                Divider()
                                    .frame(width: 100)
                                    .background(THEME.ExtraOperatorInfor_titleCharacterColor)
                            }
                        }
                    }
                }
                .padding()
                .background(
                    LinearGradient(colors: [THEME.backgroundEnd, THEME.backgroundEnd], startPoint: .leading, endPoint: .trailing)
                        .opacity(0.95)
                        .ignoresSafeArea()
                        .cornerRadius(30)
                )
                .padding()
                .transition(.scale.combined(with: .offset(x: viewModelOrder == 2 ? 150 : -150, y: 150)))
            }
        }
    }
}

struct PickerUnitPopup_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}
