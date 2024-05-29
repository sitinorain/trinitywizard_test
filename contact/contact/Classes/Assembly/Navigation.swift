//
//  Navigation.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import Foundation
import UIKit

public class Navigation {
    
    public static let shared = Navigation()
    
    init() {
        configureDefaultViews()
        SplashConfigurator.shared.delegate = self
        ListingConfigurator.shared.delegate = self
        DetailsConfigurator.shared.delegate = self
    }
    
    private func configureDefaultViews() {
        let attributes = [NSAttributedString.Key.foregroundColor: R.color.darkFont(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .bold)]
        UINavigationBar.appearance().titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        UINavigationBar.appearance().barTintColor = R.color.background()
        UINavigationBar.appearance().tintColor = R.color.themeBlue()
    }
    
    public func buildSplashViewModule() -> UIViewController {
        return SplashConfigurator.shared.createSplashScene()
    }
}
