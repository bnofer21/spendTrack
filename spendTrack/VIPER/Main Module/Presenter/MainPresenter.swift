//
//  MainPresenter.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import Foundation

protocol MainPresenterInput: AnyObject {
    func saveTrans(amount: Int, category: String, date: Date)
}

final class MainPresenter: MainRouterInput, MainViewOutput, MainInteractorOutput {    
    
    weak var view: MainViewInput?
    var interactor: MainInteractorInput?
    var router: MainRouterInput?
    
    func viewDidLoad() {
        interactor?.loadCoinPrice()
        interactor?.loadBalance()
        interactor?.loadTrans(start: 0)
    }
    
    func saveTrans(amount: Int, category: String, date: Date) {
        interactor?.saveTrans(amount: amount, category: category, date: date)
    }
    
    func didLoad(_ trans: [Transaction]) {
        let section = MainSectionModel(trans)
        view?.updateForSection(section)
    }
    
    func didLoadPrice(_ coin: Bitcoin) {
        let btcModel = InfoPriceModel(coin)
        view?.updateViewForModel(btcModel)
    }
    
    func didReceive(_ error: String) {
        view?.showError(error)
    }
    
    func didLoadBalance(_ balance: Balance) {
        let model = InfoBalanceModel(balance: balance)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) { [weak self] in
            self?.view?.updateViewForModel(model)
        }
    }
    
    func showSpendVC() {
        router?.showSpendVC()
    }
    
}

