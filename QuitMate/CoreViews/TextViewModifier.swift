//
//  TextViewModifier.swift
//  QuitMate
//
//  Created by Саша Василенко on 06.06.2023.
//

import SwiftUI

struct TextViewModifier: ViewModifier {
    let font: FontsEnum
    let size: Int
    func body(content: Content) -> some View {
        content
            .font(.custom(font.rawValue, size: CGFloat(size)))
    }
}
