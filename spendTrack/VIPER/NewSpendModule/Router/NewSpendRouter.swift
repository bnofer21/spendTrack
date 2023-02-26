//
//  NewSpendRouter.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation

protocol NewSpendRouterInput {
    func saveTrans(amount: Int, category: String, date: Date)
}


final class NewSpendRouter: NewSpendRouterInput {
    
    var mainRouter: MainRouterInput?
    
    func saveTrans(amount: Int, category: String, date: Date) {
        mainRouter?.saveTrans(amount: amount, category: category, date: date)
    }
    
}
