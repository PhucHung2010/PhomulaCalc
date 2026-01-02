//
//  ThemeStyle.swift
//  CALCULATOR
//
//  Created by Hung Nguyen on 22/08/2024.
//

import Foundation
import SwiftUI

struct ThemeStyle {
    
    // Linear Background
    let backgroundStart: Color
    let backgroundEnd: Color
    
    // Tab Bar
    /// Bar
    let Tabbar_background: Color
    let Tabbar_Shadow: Color
    /// Tab Item
    let TabItem_tint: Color
    let TabItem_activeTint: Color
    let TabItem_inactiveTint: Color
    
    // Calculation Interface
    /// Board
    let Board_Color: Color
    let Board_upShadow: Color
    let Board_upShadow_opacity: CGFloat
    let Board_upShadow_radius: CGFloat
    let Board_upShadow_x_y: CGFloat
    
    let Board_downShadow: Color
    let Board_downShadow_opacity: CGFloat
    let Board_downShadow_radius: CGFloat
    let Board_downShadow_x_y: CGFloat
    
    let Board_resultStringColor: Color
    
    // Button
    /// Tiny Func Button
    let TinyFuncButton_characterColor: Color
    let TinyFuncButton_background: Color
    let TinyFuncButton_shadow: Color
    let MoreFuncButton_characterColor: Color
    let MoreFuncButton_background: Color
    let MoreFuncButton_shadow: Color
    
    /// Circle Function Button
    let CircleFunctionButton_characterColor: Color
    /// Function Button
    let FunctionButton_characterColor: Color
    /// Number Button
    let NumberButton_characterColor: Color
    
    
    // Extra operator information sheet
    let ExtraOperatorInfor_titleCharacterColor: Color
    let ExtraOperatorInfor_title2CharacterColor: Color
    let ExtraOperatorInfor_bodyCharacterColor: Color
    let ExtraOperatorInfor_linkBackgroundStart: Color
    let ExtraOperatorInfor_linkBackgroundEnd: Color
    let ExtraOperatorInfor_linkShadow: Color
    
    
    // Text field color
    let TextField_backgroundStart: Color
    let TextField_backgroundEnd: Color
    let TextField_textColor: Color
    let TextField_AaSymbolColor: Color
    
}

struct StyleChoices {

    let lightTheme: ThemeStyle = ThemeStyle(
        backgroundStart: .offWhite,
        backgroundEnd: .offWhite,

        Tabbar_background: .offWhite,
        Tabbar_Shadow: .black,
        TabItem_tint: .darkGray,
        TabItem_activeTint: .white,
        TabItem_inactiveTint: .darkGray,

        Board_Color: .offWhite,
        Board_upShadow: .white,
        Board_upShadow_opacity: 0.9,
        Board_upShadow_radius: 10,
        Board_upShadow_x_y: -3,
        
        Board_downShadow: .black,
        Board_downShadow_opacity: 0.25,
        Board_downShadow_radius: 8,
        Board_downShadow_x_y: 8,
        
        Board_resultStringColor: .darkGray,

        TinyFuncButton_characterColor: .offWhite,
        TinyFuncButton_background: .gray,
        TinyFuncButton_shadow: .black,
        MoreFuncButton_characterColor: .white,
        MoreFuncButton_background: .darkGray2,
        MoreFuncButton_shadow: .black,
        
        CircleFunctionButton_characterColor: .darkGray,
        FunctionButton_characterColor: .darkGray,
        NumberButton_characterColor: .gray,
        
        ExtraOperatorInfor_titleCharacterColor: .darkGray,
        ExtraOperatorInfor_title2CharacterColor: .offWhite,
        ExtraOperatorInfor_bodyCharacterColor: .darkGray2,
        ExtraOperatorInfor_linkBackgroundStart: .darkGray2,
        ExtraOperatorInfor_linkBackgroundEnd: .lightGray2,
        ExtraOperatorInfor_linkShadow: .black,
        
        TextField_backgroundStart: .darkGray,
        TextField_backgroundEnd: .gray,
        TextField_textColor: .offWhite,
        TextField_AaSymbolColor: .gray
    )
    
    let darkTheme: ThemeStyle = ThemeStyle(
        backgroundStart: .darkStart,
        backgroundEnd: .darkEnd,

        Tabbar_background: .darkEnd,
        Tabbar_Shadow: .darkOffWhite2,
        TabItem_tint: .darkOffWhite,
        TabItem_activeTint: .darkEnd,
        TabItem_inactiveTint: .darkOffWhite,

        Board_Color: .darkMiddle,
        Board_upShadow: .darkOffWhite,
        Board_upShadow_opacity: 0.2,
        Board_upShadow_radius: 5,
        Board_upShadow_x_y: -2,
        
        Board_downShadow: .darkOffWhite,
        Board_downShadow_opacity: 0.2,
        Board_downShadow_radius: 5,
        Board_downShadow_x_y: 2,
        
        Board_resultStringColor: .offWhite,

        TinyFuncButton_characterColor: .darkOffWhite2,
        TinyFuncButton_background: .darkEnd,
        TinyFuncButton_shadow: .darkStart,
        MoreFuncButton_characterColor: .darkEnd,
        MoreFuncButton_background: .offWhite,
        MoreFuncButton_shadow: .white,
        
        CircleFunctionButton_characterColor: .offWhite,
        FunctionButton_characterColor: .offWhite,
        NumberButton_characterColor: .darkOffWhite,
        
        ExtraOperatorInfor_titleCharacterColor: .darkOffWhite,
        ExtraOperatorInfor_title2CharacterColor: .darkOffWhite2,
        ExtraOperatorInfor_bodyCharacterColor: .darkOffWhite2,
        ExtraOperatorInfor_linkBackgroundStart: .darkEnd,
        ExtraOperatorInfor_linkBackgroundEnd: .darkMiddle2,
        ExtraOperatorInfor_linkShadow: .black,
        
        TextField_backgroundStart: .darkStart,
        TextField_backgroundEnd: .darkMiddle,
        TextField_textColor: .offWhite,
        TextField_AaSymbolColor: .darkMiddle2
    )
    
    let defaultTheme: ThemeStyle = ThemeStyle(
        backgroundStart: .darkOffWhite2,
        backgroundEnd: .gray,

        Tabbar_background: .gray,
        Tabbar_Shadow: .black,
        TabItem_tint: .darkBlueStart,
        TabItem_activeTint: .white,
        TabItem_inactiveTint: .white,

        Board_Color: .gray,
        Board_upShadow: .white,
        Board_upShadow_opacity: 0.2,
        Board_upShadow_radius: 5,
        Board_upShadow_x_y: -2,
        
        Board_downShadow: .white,
        Board_downShadow_opacity: 0.2,
        Board_downShadow_radius: 5,
        Board_downShadow_x_y: 2,
        
        Board_resultStringColor: .offWhite,

        TinyFuncButton_characterColor: .darkOffWhite,
        TinyFuncButton_background: .darkGray,
        TinyFuncButton_shadow: .darkOffWhite2,
        MoreFuncButton_characterColor: .white,
        MoreFuncButton_background: .darkGray3,
        MoreFuncButton_shadow: .black,
        
        CircleFunctionButton_characterColor: .white,
        FunctionButton_characterColor: .white,
        NumberButton_characterColor: .offWhite,
        
        ExtraOperatorInfor_titleCharacterColor: .darkGray2,
        ExtraOperatorInfor_title2CharacterColor: .darkOffWhite2,
        ExtraOperatorInfor_bodyCharacterColor: .darkGray3,
        ExtraOperatorInfor_linkBackgroundStart: .darkGray3,
        ExtraOperatorInfor_linkBackgroundEnd: .darkGray,
        ExtraOperatorInfor_linkShadow: .black,
        
        TextField_backgroundStart: .darkGray07,
        TextField_backgroundEnd: .darkGray05,
        TextField_textColor: .white,
        TextField_AaSymbolColor: .lightGray
    )
}


struct nhap_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}
