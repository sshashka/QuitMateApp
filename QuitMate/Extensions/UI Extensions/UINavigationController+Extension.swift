//
//  UINavigationController+Extension.swift
//  QuitMate
//
//  Created by Саша Василенко on 06.07.2023.
//

import UIKit

extension UINavigationController {
    func pushWithCustomAnination(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        self.view.layer.add(transition, forKey: nil)
        self.pushViewController(viewController, animated: false)
    }
    
    func popWithCustomAnimation(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        self.view.layer.add(transition, forKey: nil)
        self.pushViewController(viewController, animated: false)
    }
}

