//
//  ListingWireframe.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import UIKit

public protocol ListingWireframe: AnyObject {
    func navigateToDetailsViewFromListing(_ listingViewController: UIViewController, withSelectedContact contact: Contact?)
}

extension Navigation: ListingWireframe {
    public func navigateToDetailsViewFromListing(_ listingViewController: UIViewController, withSelectedContact contact: Contact?) {
        guard let fromViewController = listingViewController as? ListingViewController else { return }
        let viewController = DetailsConfigurator.shared.createDetailsScene(withSelectedContact: contact)
        fromViewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
