//
//  Data+Exstension.swift
//  StopMate
//
//  Created by Саша Василенко on 04.08.2023.
//

import UIKit


extension Data {
    func compressImage(maxSizeMB: Int) -> Data? {
        guard let image = UIImage(data: self) else {
            return nil
        }
        
        var compression: CGFloat = 0.9
        let maxCompression: CGFloat = 0.1
        
        var imageData = image.jpegData(compressionQuality: compression)!
        
        while imageData.count > maxSizeMB * 1024 * 1024 && compression > maxCompression {
            compression -= 0.1
            imageData = image.jpegData(compressionQuality: compression)!
        }
        
        return imageData
    }
}

