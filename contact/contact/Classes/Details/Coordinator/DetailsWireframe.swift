//
//  DetailsWireframe.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import UIKit

public protocol DetailsWireframe: AnyObject {
    func navigateBackFromDetails(_ detailsViewController: UIViewController)
}

extension Navigation: DetailsWireframe {
    public func navigateBackFromDetails(_ detailsViewController: UIViewController) {
        guard let fromViewController = detailsViewController as? DetailsViewController else { return }
        fromViewController.navigationController?.popViewController(animated: true)
    }
}
