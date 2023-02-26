//
//  NewSpendInteractor.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation

protocol NewSpendInteractorInput {
    var output: NewSpendInteractorOutput? { get set }
    func configureCategories()
    func saveTrans(amount: Int, category: String, date: Date)
}

protocol NewSpendInteractorOutput: AnyObject {
    func didConfigureCategories(_ categories: [String])
    func didReceive(_ error: String)
    func didSaveTrans()
}

final class NewSpendInteractor: NewSpendInteractorInput {
    
    weak var output: NewSpendInteractorOutput?
    var dataManager: DataManagerInterface?
    
    internal func configureCategories() {
        var strCategories = [String]()
        var _ = (Resources.Category.allCases)
            .filter { $0 != .income}
            .forEach { strCategories.append($0.rawValue) }
        output?.didConfigureCategories(strCategories)
    }
    
    internal func saveTrans(amount: Int, category: String, date: Date) {
        dataManager?.saveTrans(amount: amount, category: category, date: date, completion: { [weak self] error in
            if let error = error {
                self?.output?.didReceive(error)
            } else {
                self?.output?.didSaveTrans()
            }
        })
    }
}
