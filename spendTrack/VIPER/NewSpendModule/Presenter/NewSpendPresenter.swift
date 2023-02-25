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
        <#code#>
    }
    
    func saveTrans(amount: Int, category: String, date: Date) {
        router?.saveTrans(amount: amount, category: category, date: date)
    }
}
