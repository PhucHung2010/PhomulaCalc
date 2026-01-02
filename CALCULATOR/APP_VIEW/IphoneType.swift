//
//  IphoneType.swift
//  CALCULATOR
//
//  Created by Hung Nguyen on 20/08/2024.
//

import SwiftUI
import Foundation

struct Iphone_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}

struct Iphone {
    let CalculationUI_Scale: CGFloat
    let tinyFunc_gridWidth: CGFloat
    let func_gridWidth: CGFloat
    let num_gridWidth: CGFloat
    let zeroWidth: CGFloat
    let boardWidth: CGFloat
    let spacing: CGFloat
    let tabbarOffset: CGFloat
    let tabItemScale: CGFloat
    let tabbarTopPadding: CGFloat
    let sheetScale: CGFloat
    let extraOperatorScale: CGFloat
}

struct IphoneType {
    let Iphone_6_6s_7_8_SE: Iphone = Iphone(
        CalculationUI_Scale: 0.85,
        tinyFunc_gridWidth: 75,
        func_gridWidth: 30,
        num_gridWidth: 25,
        zeroWidth: 305,
        boardWidth: 390,
        spacing: -10,
        tabbarOffset: 8,
        tabItemScale: 0.8,
        tabbarTopPadding: -14,
        sheetScale: 0.9,
        extraOperatorScale: 0.885
    )
    

    let Iphone_6plus_6splus_7plus_8plus: Iphone = Iphone(
        CalculationUI_Scale: 0.935,
        tinyFunc_gridWidth: 72,
        func_gridWidth: 28,
        num_gridWidth: 23,
        zeroWidth: 315,
        boardWidth: 390,
        spacing: -8,
        tabbarOffset: 5,
        tabItemScale: 0.87,
        tabbarTopPadding: -13,
        sheetScale: 0.92,
        extraOperatorScale: 1
    )
    
    let Iphone_X_XS_11pro: Iphone = Iphone(
        CalculationUI_Scale: 0.92,
        tinyFunc_gridWidth: 70,
        func_gridWidth: 25,
        num_gridWidth: 20,
        zeroWidth: 310,
        boardWidth: 360,
        spacing: -15,
        tabbarOffset: 15,
        tabItemScale: 1,
        tabbarTopPadding: -10,
        sheetScale: 1,
        extraOperatorScale: 0.97
    )
    
    let Iphone_XR_XSmax_11_11promax: Iphone = Iphone(
        CalculationUI_Scale: 1.05,
        tinyFunc_gridWidth: 65,
        func_gridWidth: 20,
        num_gridWidth: 15,
        zeroWidth: 295,
        boardWidth: 360,
        spacing: -15,
        tabbarOffset: 15,
        tabItemScale: 1,
        tabbarTopPadding: -10,
        sheetScale: 1.1,
        extraOperatorScale: 1.03
    )
    
    let Iphone_12_12pro_13_13pro_14_14pro_15_15pro: Iphone = Iphone(
        CalculationUI_Scale: 1,
        tinyFunc_gridWidth: 65,
        func_gridWidth: 20,
        num_gridWidth: 15,
        zeroWidth: 295,
        boardWidth: 360,
        spacing: -20,
        tabbarOffset: 20,
        tabItemScale: 1,
        tabbarTopPadding: -10,
        sheetScale: 1,
        extraOperatorScale: 1
    )
    
    let Iphone_12promax_13promax_14promax_14plus_15promax_15plus: Iphone = Iphone(
        CalculationUI_Scale: 1.1,
        tinyFunc_gridWidth: 65,
        func_gridWidth: 20,
        num_gridWidth: 15,
        zeroWidth: 295,
        boardWidth: 360,
        spacing: -20,
        tabbarOffset: 20,
        tabItemScale: 1,
        tabbarTopPadding: -10,
        sheetScale: 1.15,
        extraOperatorScale: 1.1
    )
    
    let Iphone_12mini_13mini: Iphone = Iphone(
        CalculationUI_Scale: 0.92,
        tinyFunc_gridWidth: 65,
        func_gridWidth: 20,
        num_gridWidth: 15,
        zeroWidth: 295,
        boardWidth: 360,
        spacing: -10,
        tabbarOffset: 20,
        tabItemScale: 1,
        tabbarTopPadding: -10,
        sheetScale: 0.92,
        extraOperatorScale: 0.9
    )

}




