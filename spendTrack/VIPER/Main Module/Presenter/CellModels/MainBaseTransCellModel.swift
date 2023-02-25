//
//  MainBaseTransCellModel.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import Foundation

final class MainBaseTransCellModel: MainBaseCellModel {
    
    override var cellIdentifier: String {
        return "MainBaseTransCell"
    }
    
    override var cellHeight: Float {
        return 50
    }
    
    var transaction: Transaction
    
    var amount: Int {
        return Int(transaction.amount)
    }
    
    var category: String {
        guard let category = transaction.category else { return "" }
        return category
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
    
    init(_ transaction: Transaction) {
        self.transaction = transaction
    }
}
