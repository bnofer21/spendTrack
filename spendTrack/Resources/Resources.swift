//
//  Resources.swift
//  spendTrack
//
//  Created by ะฎัะธะน on 24.12.2022.
//

import Foundation

enum Resources {
    
    enum Category: String, CaseIterable {
        case care = "๐"
        case groceries = "๐"
        case entertainment = "๐น"
        case education = "๐ฉโ๐"
        case income = "๐ค"
    }
    
    enum TransactionType: Int32, CaseIterable {
        case income = 0
        case spend = 1
        case unknown = 2
    }
}
