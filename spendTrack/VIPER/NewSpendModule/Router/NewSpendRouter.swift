//
//  NewSpendRouter.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation

protocol NewSpendRouterInput {
    var output: NewSpendRouterOutput? { get set }
    func saveTrans(amount: Int, category: String, date: Date)
}

protocol NewSpendRouterOutput: AnyObject {
    func moveDataToMainVc(amount: Int, category: String, date: Date)
}

final class NewSpendRouter: NewSpendRouterInput {
    
    weak var output: NewSpendRouterOutput?
    
    func saveTrans(amount: Int, category: String, date: Date) {
        output?.moveDataToMainVc(amount: amount, category: category, date: date)
    }
}
