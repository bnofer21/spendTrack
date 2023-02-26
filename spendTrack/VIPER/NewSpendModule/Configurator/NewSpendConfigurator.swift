//
//  NewSpendConfigurator.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation
import UIKit

final class NewSpendConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        
        if let vc = viewInput as? NewSpendViewController {
            configure(viewController: vc)
        }
    }
    
    private func configure(viewController: NewSpendViewController) {
        
        let router = NewSpendRouter()
        let presenter = NewSpendPresenter()
        let interactor = NewSpendInteractor()
        
        presenter.view = viewController
        presenter.router = router
        
        interactor.output = presenter
        interactor.dataManager = DataManager()
        
        presenter.interactor = interactor
        
        viewController.output = presenter
    }
}
