//
//  PoppinsTextStyles.swift
//  QuitMate
//
//  Created by Саша Василенко on 10.06.2023.
//

import Foundation

enum PoppinsTextStyles {
    
    typealias fontTuple = (font: FontsEnum, size: CGFloat)
    case header, header2, textViewText, buttonsText, clearButtonsText, greyHeaderText, recomendationsText, textFieldText, poppinsSemibold16, videoTitle
    
    func getTextStyle(style: PoppinsTextStyles) -> fontTuple {
        switch style {
        case .header:
            return (font: FontsEnum.poppinsSemiBold, size: 36)
        case .textViewText:
            return (font: FontsEnum.poppinsRegular, size: 14)
        case .buttonsText:
            return (font: FontsEnum.poppinsSemiBold, size: 14)
        case .clearButtonsText:
            return (font: FontsEnum.poppinsSemiBold, size: 14)
        case .greyHeaderText:
            return (font: FontsEnum.poppinsMedium, size: 16)
        case .recomendationsText:
            return (font: FontsEnum.poppinsMedium, size: 18)
        case .textFieldText:
            return (font: FontsEnum.poppinsRegular, size: 14)
        case .poppinsSemibold16:
            return (font: FontsEnum.poppinsSemiBold, size: 16)
        case .videoTitle:
            return (font: FontsEnum.poppinsBold, size: 16)
        case .header2:
            return (font: FontsEnum.poppinsSemiBold, size: 26)
        }
    }
//    static var header: fontTuple {
//        return (font: FontsEnum.poppinsSemiBold, size: 36)
//    }
//
//    static var textViewText: fontTuple {
//        return (font: FontsEnum.poppinsRegular, size: 14)
//    }
//
//    static var buttonsText: fontTuple {
//        return (font: FontsEnum.poppinsSemiBold, size: 14)
//    }
//
//    static var clearButtonsText: fontTuple {
//        return (font: FontsEnum.poppinsRegular, size: 14)
//    }
//
//    static var greyHeaderText: fontTuple {
//        return (font: FontsEnum.poppinsMedium, size: 16)
//    }
//
//    static var recomendationsText: fontTuple {
//        return (font: FontsEnum.poppinsMedium, size: 18)
//    }
}
