//
//  UINavigationController+Extension.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import UIKit

extension UINavigationController {
    open func fadeViewController (viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.view.layer.add(transition, forKey: nil)
        self.pushViewController(viewController, animated: false)
    }
}
