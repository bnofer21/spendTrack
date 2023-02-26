//
//  MainInteractor.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import Foundation

protocol MainInteractorInput {
    var output: MainInteractorOutput? { get set }
    func loadTrans(start: Int)
    func loadBalance()
    func loadCoinPrice()
    func saveTrans(amount: Int, category: String, date: Date)
}

protocol MainInteractorOutput {
    func didLoad(_ trans: [Transaction])
    func didLoadPrice(_ coin: Bitcoin)
    func didReceive(_ error: String)
    func didLoadBalance(_ balance: Balance)
}

final class MainInteractor: MainInteractorInput {
    
    var output: MainInteractorOutput?
    
    var priceLoader: PriceLoaderInteface?
    var dataManager: DataManagerInterface?
    
    func loadTrans(start: Int) {
        dataManager?.loadTrans(startIndex: start, completion: { [weak self] trans, error in
            if let error = error {
                self?.output?.didReceive(error)
            } else if let trans = trans {
                self?.output?.didLoad(trans)
            } else {
                self?.output?.didReceive("Error loading data")
            }
        })
    }
    
    func loadCoinPrice() {
        priceLoader?.loadPrice(completion: { [weak self] btc, error in
            if let error = error {
                self?.output?.didReceive(error)
            } else if let btc = btc {
                self?.output?.didLoadPrice(btc)
            } else {
                self?.output?.didReceive("Error loading BTC price")
            }
        })
    }
    
    func loadBalance() {
        dataManager?.loadBalance(completion: { [weak self] balance, error in
            if let error = error {
                self?.output?.didReceive(error)
            } else if let balance = balance {
                self?.output?.didLoadBalance(balance)
            } else {
                self?.output?.didReceive("Error loading balance")
            }
        })
    }
    
    func saveTrans(amount: Int, category: String, date: Date) {
        dataManager?.saveTrans(amount: amount, category: category, date: date, completion: { [weak self] error in
            if let error = error {
                self?.output?.didReceive(error)
            } else {
                self?.loadTrans(start: 0)
                self?.loadBalance()
            }
        })
    }
    
    
    
}
