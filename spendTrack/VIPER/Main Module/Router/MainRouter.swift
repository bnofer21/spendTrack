//
//  MainRouter.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import Foundation

protocol MainRouterInput {
    func saveTrans(amount: Int, category: String, date: Date)
}

class MainRouter: MainRouterInput {
    
    weak var presenter: MainPresenterInput?
    
    var newSpendRouter: NewSpendRouterInput?
    
    func saveTrans(amount: Int, category: String, date: Date) {
        presenter?.saveTrans(amount: amount, category: category, date: date)
    }
    
}
