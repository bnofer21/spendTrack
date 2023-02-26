//
//  RootWireframe.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import UIKit

final class RootWireframe {
    
    class func setupWith(_ window: UIWindow) {
        let vc = MainViewController()
        let conf = MainConfigurator()
        conf.configureModuleForViewInput(viewInput: vc)
        
        let navVC = UINavigationController(rootViewController: vc)
        
        window.rootViewController = navVC
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
    }
}
