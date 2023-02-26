//
//  RootWireframe.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import UIKit

final class RootWireframe {
    
    class func setupWith(_ window: UIWindow) {
        let coordinator = MainCoordinator()
        let navVC = UINavigationController()
        
        coordinator.navigationController = navVC
        
        window.rootViewController = navVC
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
        
        coordinator.start()
    }
}
