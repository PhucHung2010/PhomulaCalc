////
////  ContentView.swift
////  CALCULATOR
////
////  Created by Hung Nguyen on 12/08/2024.
////
//

//  DIFFERENCE IPHONE VIEW

import SwiftUI
import UIKit
import Foundation



struct ContentViewCalculator: View {
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        if height >= 920 {
            WideTabView(iphone: IphoneType().Iphone_12promax_13promax_14promax_14plus_15promax_15plus)
        }
        else if height >= 890 {
            WideTabView(iphone: IphoneType().Iphone_XR_XSmax_11_11promax)
        }
        else if height >= 840 {
            WideTabView(iphone: IphoneType().Iphone_12_12pro_13_13pro_14_14pro_15_15pro)
        }
        else if height >= 800 {
            WideTabView(iphone: IphoneType().Iphone_X_XS_11pro)
        }
        else if height >= 770 {
            WideTabView(iphone: IphoneType().Iphone_12mini_13mini)
        }
        else if height >= 720 {
            WideTabView(iphone: IphoneType().Iphone_6plus_6splus_7plus_8plus)
        }
        else {
            WideTabView(iphone: IphoneType().Iphone_6_6s_7_8_SE)
        }
    }
}



struct ContentViewCalculator_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}

