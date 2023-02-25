//
//  MainRouter.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import Foundation

protocol MainRouterInput {
    func showSpendVC()
}

class MainRouter: MainRouterInput, NewSpendRouterOutput {
    
    weak var presenter: MainPresenterInput?
    
    var newSpendRouter: NewSpendRouterInput?
    
    func moveDataToMainVc(amount: Int, category: String, date: Date) {
        presenter?.saveTrans(amount: amount, category: category, date: date)
    }
    
    func showSpendVC() {
//        let vc = NewSpendController(balance: <#T##Balance#>)
    }
    
}
