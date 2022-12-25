//
//  TransactionViewModel.swift
//  spendTrack
//
//  Created by Юрий on 25.12.2022.
//

import Foundation

struct TransactionViewModel {
    
    var transaction: Transaction
    
    var amount: Int {
        return Int(transaction.amount)
    }
    
    var category: String {
        return transaction.category!
    }
    
    var date: String {
        guard let date = transaction.date else { return "" }
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy HH:mm"
        return df.string(from: date)
    }
    
    var type: Resources.TransactionType {
        let type = Resources.TransactionType.allCases[Int(transaction.type)]
        return type
    }
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
}
