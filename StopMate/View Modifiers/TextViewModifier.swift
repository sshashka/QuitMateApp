//
//  TextViewModifier.swift
//  QuitMate
//
//  Created by Саша Василенко on 06.06.2023.
//

import SwiftUI

struct TextViewModifier: ViewModifier {
    private let font: FontsEnum
    private let size: CGFloat
    
    init(font: FontsEnum, size: CGFloat) {
        self.font = font
        self.size = size
    }
    
    init(_ fontTuple: Exo2TextStyles.fontTuple) {
        self.font = fontTuple.font
        self.size = fontTuple.size
    }
    
    func body(content: Content) -> some View {
        content
            .font(.custom(font.rawValue, size: size))
    }
}
