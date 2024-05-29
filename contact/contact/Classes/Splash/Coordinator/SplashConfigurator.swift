//
//  SplashConfigurator.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import UIKit

public class SplashConfigurator {
    public static var shared = SplashConfigurator()
    public weak var delegate: SplashWireframe?

    public func createSplashScene() -> UIViewController {
        let viewController = SplashViewController.fromStoryboard()
        viewController.viewModel = SplashViewModel()
        return viewController
    }
}
