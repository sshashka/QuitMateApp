//
//  TabBarPages.swift
//  QuitMate
//
//  Created by Саша Василенко on 07.04.2023.
//

// Remove later
import UIKit

enum TabBarPages {
    case charts, home, videos
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .charts
        case 1:
            self = .home
        case 2:
            self = .videos
        default:
            return nil
        }
    }
    
    func getImages() -> UIImage {
        switch self {
        case .charts:
            return UIImage(systemName: "chart.xyaxis.line")!
        case .home:
            return UIImage(systemName: "house")!
        case .videos:
            return UIImage(systemName: "video")!
        }
    }
}
