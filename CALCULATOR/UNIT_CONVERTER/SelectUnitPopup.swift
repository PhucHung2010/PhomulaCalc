//
//  SelectUnitPopup.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 15/10/2024.
//

import SwiftUI

struct SelectUnitPopup: View {
    @Binding var showPopup: Bool
    @ObservedObject var viewModel: DetailViewModel
    @State private var showNumpad = false
    @State private var showInfo = false
    @State private var viewModelOrder1 = 0
    @State private var viewModelOrder2 = 0
    
    @State private var isOptionsPresented: Bool = false
    
    var THEME: ThemeStyle
    var scaleEffect: CGFloat
    
    var category: Category
    
    var body: some View {
        ZStack {
            if showPopup {
                BlurView(style: .systemUltraThinMaterialDark)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.easeInOut(duration: 0.32)) {
                            showPopup = false
                        }
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.1)) {
                            showNumpad = false
                            viewModelOrder1 = 0
                            viewModelOrder2 = 0
                            showInfo = false
                        }
                        
                        
                    }
                    .transition(.opacity)
            }

            // Pop-up Content with blur background
            if showPopup {
                VStack(spacing: 25) {

                    if !showNumpad {
                        HStack {
                            Image(systemName: "\(CategoryManager.getIcon(category: category))")
                                .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                                .font(.system(size: 35))
                                
                            Text("\(category.rawValue)")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                            
                            VStack(alignment: .trailing) {
                                Button(action: {
                                    withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.6, blendDuration: 0.1)) {
                                        showInfo.toggle()
                                    }
                                }) {
                                    Symbol("info.circle", symbolColor: THEME.MoreFuncButton_background, symbolSize: 20)
                                }
                                .buttonStyle(ScaledButtonStyle(scaleRadius: 3))
                            }
                        }
                        .frame(height: 40)
                    }

                    
                    
                    if !showNumpad {
                        Spacer().frame(width: 120, height: 50)
                    }
                    
                    
                    

                    VStack (spacing: 10){
                        ConvertResultBoard(numString: viewModel.firstUnitValue, THEME: THEME, widthNumber: 300, heightNumber: 60)
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.6, blendDuration: 0.1)) {
                                    showNumpad.toggle()
                                    showInfo = false
                                }
                            }
                        
                        
                        Image(systemName: "arrow.down")
                            .font(.system(size: 30, weight: .black))
                            .foregroundColor(THEME.Board_resultStringColor)
                            .frame(height: 35)
                        
                        
                        ConvertResultBoard(
                            numString: "\(viewModel.convert(value: viewModel.firstUnitValue, unit1: viewModel.units[viewModel.firstUnit], unit2: viewModel.units[viewModel.secondUnit]))",
                            THEME: THEME,
                            widthNumber: 300, heightNumber: 60)
                        
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.42, dampingFraction: 0.63, blendDuration: 0.1)) {
                                    showNumpad.toggle()
                                    showInfo = false
                                }
                            }
                        
                    }
                    
                    NumpadKeyboardPopup(valueString: $viewModel.firstUnitValue, THEME: THEME, showNumpad: $showNumpad)
                }
                .shadow(radius: 3)
                .frame(minHeight: 300)
                .padding()
                .background(
                    THEME.Board_Color
                        .ignoresSafeArea()
                        .cornerRadius(25)
                        .shadow(radius: 7)
                )
                .overlay(alignment: .top) {
                    VStack {
                        Spacer(minLength: 350)
                        InfoPopup(showPopup: $showInfo, category: category, THEME: THEME)
                            .frame(height: 250)
                    }
                }
                .transition(.scale.combined(with: .opacity))
                .padding(.bottom, showInfo ? 250 : 0)
                .scaleEffect(scaleEffect < 1 ? 1 : scaleEffect)
            }
            
            
            
            
            
            // DROP DOWN MENU
            
            if showPopup && !showNumpad {
                VStack (spacing: 25) {
                    Spacer().frame(height: 30)
                    
                    HStack (spacing: 0){
                        
                        Button(action: {
                            if viewModelOrder1 == 0 {
                                withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.6, blendDuration: 0.1)) {
                                    viewModelOrder1 = 1
                                }
                            }
                            else {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    viewModelOrder1 = 0
                                }
                            }
                        }) {

                            Number("\(viewModel.units[viewModel.firstUnit].symbol)",
                                   numberColor: THEME.TinyFuncButton_characterColor,
                                   fontWeight: .bold,
                                   fontSize: 30)
                            .frame(width: 120, height: 50)
                        }
                        .buttonStyle(TinyFuncButtonStyle(widthNum: 200, heightNum: 90, cornerRadius: 45, symbolScaleEffect: 0.5, backgroundScaleEffect: 0.4, THEME: THEME))
                        .overlay(alignment: .top) {
                            VStack {
                                Spacer(minLength: 50)
                                
                                PickerUnitPopup(viewModel: viewModel, viewModelOrder: $viewModelOrder1, THEME: THEME)
                            }
                            .frame(height: CGFloat(viewModel.units.count) * 90 > 350 ? 350 : CGFloat(viewModel.units.count) * 90)
                        }
                        
                        
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 30, weight: .black))
                            .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                            .padding(.horizontal, 15)
                            .frame(height: 30)
                        
                        
                        
                        
                        Button(action: {
                            if viewModelOrder2 == 0 {
                                withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.6, blendDuration: 0.1)) {
                                    viewModelOrder2 = 2
                                }
                            }
                            else {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    viewModelOrder2 = 0
                                }
                            }
                            
                        }) {
                            Number("\(viewModel.units[viewModel.secondUnit].symbol)",
                                   numberColor: THEME.TinyFuncButton_characterColor,
                                   fontWeight: .bold,
                                   fontSize: 30)
                            .frame(width: 120, height: 50)
                        }
                        .buttonStyle(TinyFuncButtonStyle(widthNum: 200, heightNum: 90, cornerRadius: 45, symbolScaleEffect: 0.5, backgroundScaleEffect: 0.4, THEME: THEME))
                        .overlay(alignment: .top) {
                            
                            VStack {
                                Spacer(minLength: 50)
                                
                                PickerUnitPopup(viewModel: viewModel, viewModelOrder: $viewModelOrder2, THEME: THEME)
                            }
                            .frame(height: CGFloat(viewModel.units.count) * 90 > 350 ? 350 : CGFloat(viewModel.units.count) * 90)
                        }
                    }
                    
                    VStack(spacing: 10) {
                        Spacer().frame(height: 60)
                        Spacer().frame(height: 35)
                        Spacer().frame(height: 60)
                    }
                }
                .shadow(radius: 3)
                .frame(minHeight: 300)
                .scaleEffect(scaleEffect < 1 ? 1 : scaleEffect)
                .padding()
                .transition(.scale.combined(with: .opacity))
                .padding(.bottom, showInfo ? 250 : 0)
            }
            
        }
    }
}





struct SelectUnitPopup_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}
