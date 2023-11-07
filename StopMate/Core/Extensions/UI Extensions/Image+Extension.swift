//
//  Image+Extension.swift
//  StopMate
//
//  Created by Саша Василенко on 04.08.2023.
//

import SwiftUI

extension Image {
    func fromData(with data: Data?) -> Image {
        guard let data else { return Image(IconConstants.noProfilePic)}
        let UIKitImage = UIImage(data: data)
        guard let UIKitImage else { return Image(IconConstants.noProfilePic)}
        return Image(uiImage: UIKitImage)
    }
}
