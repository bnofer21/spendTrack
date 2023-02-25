//
//  NewSpendBaseCategoryCellModel.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation

final class NewSpendBaseCategoryCellModel: NewSpendBaseCellModel {
    
    override var cellIdentifier: String {
        return "NewSpendBaseCategoryCell"
    }
    
    var category: Resources.Category.RawValue
    
    init(category: Resources.Category.RawValue) {
        self.category = category
    }
}
