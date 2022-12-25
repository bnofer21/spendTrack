//
//  Resources.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import Foundation

enum Resources {
    
    enum Category: String, CaseIterable {
        case care = "🚘"
        case groceries = "🛒"
        case entertainment = "🍹"
        case education = "👩‍🎓"
        case income = "🤑"
    }
    
    enum TransactionType: Int32, CaseIterable {
        case income = 0
        case spend = 1
        case unknown = 2
    }
}
