//
//  BalanceModel.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import Foundation

final class InfoBalanceModel: InfoModel {
    
    var balance: Balance
    
    override var identifier: String {
        return "BalanceModel"
    }
    
    var currentbalance: String {
        return "\(balance.currentBalance) $"
    }
    
    var allTimeSpent: String {
        return "\(balance.spendAllTime) $"
    }
    
    var todaySpent: String {
        return "\(balance.spendToday) $"
    }
    
    init(balance: Balance) {
        self.balance = balance
    }
}
