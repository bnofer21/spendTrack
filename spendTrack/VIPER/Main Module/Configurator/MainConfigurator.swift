//
//  MainConfigurator.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import Foundation

final class MainConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        
        if let vc = viewInput as? MainViewController {
            configure(viewController: vc)
        }
    }
    
    private func configure(viewController: MainViewController) {
        
        let router = MainRouter()
        
        let presenter = MainPresenter()
        presenter.view = viewController
        presenter.router = router
        
        let interactor = MainInteractor()
        interactor.output = presenter
        interactor.priceLoader = PriceLoader()
        interactor.dataManager = DataManager()
        
        presenter.interactor = interactor
        viewController.output = presenter
    }
}
