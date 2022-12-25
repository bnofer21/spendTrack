//
//  BalanceViewModel.swift
//  spendTrack
//
//  Created by Юрий on 25.12.2022.
//

import Foundation

struct BalanceViewModel {
    
    var balance: Balance
    var transactions: [Transaction]
    
    var currentbalance: Int {
        return Int(balance.currentBalance)
    }
    
    var allTimeSpent: Int {
        return Int(balance.spendAllTime)
    }
    
    var todaySpent: Int {
        let calendar = Calendar.current
        print(transactions)
        let filtered = transactions.filter({ calendar.isDateInToday($0.date!) && $0.category != "🤑" })
        var amount = 0
        for trans in filtered {
            amount += Int(trans.amount)
        }
        return amount
    }
    
    init(balance: Balance, transactions: [Transaction]) {
        self.balance = balance
        self.transactions = transactions
    }
}
