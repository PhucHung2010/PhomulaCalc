//
//  tab.swift
//  CALCULATOR
//
//  Created by Hung Nguyen on 17/08/2024.
//

import Foundation

enum Tab: String, CaseIterable {
    case setting = "Setting"
    case converter = "Converter"
    case home = "Home"
    case draw = "Draw"
    case more = "More"
    
    var systemImage: String {
        switch self {
        case .setting:
            return "gearshape"
        case .converter:
            return "arrow.left.arrow.right"
        case .home:
            return "divide"
        case .draw:
            return "pencil.tip.crop.circle"
        case .more:
            return "ellipsis"
        }
    }
        
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}

