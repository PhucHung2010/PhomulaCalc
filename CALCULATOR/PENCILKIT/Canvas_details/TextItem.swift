//
//  TextItem.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 11/10/2024.
//

import Foundation
import SwiftUI
import UIKit


struct TextItem: Identifiable {
    var id = UUID()
    var text: String
    var color: Color
    var uiColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    var fontSize: CGFloat
    var fontWeight: Font.Weight
    var fontDesign: Font.Design
    var position: CGPoint
    var offset: CGSize = .zero
    var isDragging: Bool = false
    var isScrolling: Bool = false
}




struct TextItemCodable: Codable {
    var text: String
    var fontSize: CGFloat
    var fontWeight: String
    var fontDesign: String
    var positionX: Double
    var positionY: Double
    var colorR: Double
    var colorG: Double
    var colorB: Double
    var colorAlpha: Double
}





extension Font.Weight {
    func toString() -> String {
        switch self {
        case .light: return "light"
        case .medium: return "medium"
        case .bold: return "bold"
        default: return "default"
        }
    }
}

extension Font.Design {
    func toString() -> String {
        switch self {
        case .rounded: return "rounded"
        case .serif: return "serif"
        default: return "default"
        }
    }
}


extension String {
    func toFontWeight() -> Font.Weight {
        switch self {
        case "light": return .light
        case "medium": return .medium
        case "bold": return .bold
        default: return .regular
        }
    }

    func toFontDesign() -> Font.Design {
        switch self {
        case "rounded": return .rounded
        case "serif": return .serif
        default: return .default
        }
    }
}





extension TextItem {
    func toCodable() -> TextItemCodable {
        return TextItemCodable(
            text: text,
            fontSize: fontSize,
            fontWeight: fontWeight.toString(),
            fontDesign: fontDesign.toString(),
            positionX: Double(position.x),
            positionY: Double(position.y),
            colorR: Double(uiColor.cgColor.components?[0] ?? 0),
            colorG: Double(uiColor.cgColor.components?[1] ?? 0),
            colorB: Double(uiColor.cgColor.components?[2] ?? 0),
            colorAlpha: Double(uiColor.cgColor.alpha)
        )
    }
}


extension TextItemCodable {
    func toTextItem() -> TextItem {
        return TextItem(
            text: text,
            color: Color(red: colorR, green: colorG, blue: colorB, opacity: colorAlpha),
            uiColor: UIColor(red: CGFloat(colorR), green: CGFloat(colorG), blue: CGFloat(colorB), alpha: CGFloat(colorAlpha)),
            fontSize: fontSize,
            fontWeight: fontWeight.toFontWeight(),
            fontDesign: fontDesign.toFontDesign(),
            position: CGPoint(x: positionX, y: positionY)
        )
    }
}





func encodeTextItemCodable(textItemCodable: TextItemCodable) -> String? {
    let encoder = JSONEncoder()
    if let jsonData = try? encoder.encode(textItemCodable) {
        return String(data: jsonData, encoding: .utf8)
    }
    return nil
}

// Giải mã JSON thành TextItemCodable
func decodeTextItemCodable(jsonString: String) -> TextItemCodable? {
    let decoder = JSONDecoder()
    if let jsonData = jsonString.data(using: .utf8) {
        return try? decoder.decode(TextItemCodable.self, from: jsonData)
    }
    return nil
}



func encodeTextItems(items: [TextItem]) -> String? {
    let codableItems = items.map { $0.toCodable() } // Chuyển mỗi TextItem thành TextItemCodable
    let encoder = JSONEncoder()
    
    if let jsonData = try? encoder.encode(codableItems) {
        return String(data: jsonData, encoding: .utf8)
    }
    return nil
}



func decodeTextItems(jsonString: String) -> [TextItem]? {
    let decoder = JSONDecoder()
    
    if let jsonData = jsonString.data(using: .utf8),
       let codableItems = try? decoder.decode([TextItemCodable].self, from: jsonData) {
        return codableItems.map { $0.toTextItem() } // Chuyển mỗi TextItemCodable về TextItem
    }
    return nil
}
