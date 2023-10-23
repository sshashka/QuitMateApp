//
//  MontserratTextStyles.swift
//  QuitMate
//
//  Created by Саша Василенко on 10.06.2023.
//

import Foundation

enum Exo2TextStyles {
    
    typealias fontTuple = (font: FontsEnum, size: CGFloat)
    case header, header2, textViewText, buttonsText, clearButtonsText, greyHeaderText, recomendationsText, textFieldText, customSemibold16, videoTitle, regularText, customMedium20, customSemibold18, veryBigBoldFont
    
    func getTextStyle(style: Exo2TextStyles) -> fontTuple {
        switch style {
        case .header:
            return (font: FontsEnum.semiBold, size: 36)
        case .textViewText:
            return (font: FontsEnum.regular, size: 16)
        case .buttonsText:
            return (font: FontsEnum.semiBold, size: 16)
        case .clearButtonsText:
            return (font: FontsEnum.semiBold, size: 14)
        case .greyHeaderText:
            return (font: FontsEnum.medium, size: 16)
        case .recomendationsText:
            return (font: FontsEnum.medium, size: 22)
        case .textFieldText:
            return (font: FontsEnum.regular, size: 15)
        case .customSemibold16:
            return (font: FontsEnum.semiBold, size: 16 + 2)
        case .videoTitle:
            return (font: FontsEnum.bold, size: 16)
        case .header2:
            return (font: FontsEnum.semiBold, size: 26)
        case .regularText:
            return (font: FontsEnum.regular, size: 16)
        case .customMedium20:
            return (font: FontsEnum.medium, size: 20)
        case .customSemibold18:
            return (font: FontsEnum.semiBold, size: 20)
        case .veryBigBoldFont:
            return (font: FontsEnum.semiBold, size: 95)
        }
    }
}
