//
//  Coordinator.swift
//  spendTrack
//
//  Created by Юрий on 26.02.2023.
//

import Foundation
import UIKit

enum Event {
    case newSpend
    case didAddSpend
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func eventOccured(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccured(with type: Event) {
        switch type {
        case .newSpend:
            let conf = NewSpendConfigurator()
            var vc: UIViewController & Coordinating = NewSpendViewController()
            vc.coordinator = self
            conf.configureModuleForViewInput(viewInput: vc)
            navigationController?.pushViewController(vc, animated: true)
        case .didAddSpend:
            navigationController?.viewControllers.first?.viewDidLoad()
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func start() {
        let conf = MainConfigurator()
        var vc: UIViewController & Coordinating = MainViewController()
        conf.configureModuleForViewInput(viewInput: vc)
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
    
}
