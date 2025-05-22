//
//  Font+Extension.swift
//  Memento
//
//  Created by Divakar T R on 21/05/25.
//

import Foundation
import SwiftUICore

extension Font {
    static func sfPro(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        let fontName: String
        switch weight {
        case .light: fontName = "SFPro-Light"
        case .bold: fontName = "SFPro-Bold"
        case .semibold: fontName = "SFPro-Semibold"
        case .medium: fontName = "SFPro-Medium"
        default: fontName = "SFPro-Regular"
        }
        return .custom(fontName, size: size)
    }
}
