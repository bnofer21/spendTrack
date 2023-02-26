//
//  NewSpendPresenter.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation

protocol NewSpendPresenterInput {
    
}

final class NewSpendPresenter: NewSpendPresenterInput, NewSpendViewOutput, NewSpendInteractorOutput {
    
    weak var view: NewSpendViewInput?
    var interactor: NewSpendInteractorInput?
    var router: NewSpendRouterInput?
    
    func viewDidLoad() {
        interactor?.configureCategories()
    }
    
    func didConfigureCategories(_ categories: [String]) {
        let section = NewSpendSectionModel(categories)
        view?.updateForSection(section)
    }
    
    func saveTrans(amount: Int, category: String, date: Date) {
        interactor?.saveTrans(amount: amount, category: category, date: date)
    }
    
    func didSaveTrans() {
        view?.dismissVC()
    }
    
    func didReceive(_ error: String) {
        view?.showError(error)
    }
}
