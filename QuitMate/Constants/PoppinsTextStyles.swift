//
//  PoppinsTextStyles.swift
//  QuitMate
//
//  Created by Саша Василенко on 10.06.2023.
//

import Foundation

class PoppinsTextStyles {
    typealias fontTuple = (font: FontsEnum, size: CGFloat)
    static var header: fontTuple {
        return (font: FontsEnum.poppinsSemiBold, size: 36)
    }
    
    static var textViewText: fontTuple {
        return (font: FontsEnum.poppinsRegular, size: 14)
    }
    
    static var buttonsText: fontTuple {
        return (font: FontsEnum.poppinsSemiBold, size: 14)
    }
    
    static var clearButtonsText: fontTuple {
        return (font: FontsEnum.poppinsRegular, size: 14)
    }
    
    static var greyHeaderText: fontTuple {
        return (font: FontsEnum.poppinsMedium, size: 16)
    }
    
    static var recomendationsText: fontTuple {
        return (font: FontsEnum.poppinsMedium, size: 18)
    }
}
