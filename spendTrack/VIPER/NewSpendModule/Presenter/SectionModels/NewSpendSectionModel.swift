//
//  NewSpendSectionModel.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation

class NewSpendSectionModel: CollectionSectionRowsRepresentable {
    var rows: [CollectionCellIdentifiable]
    
    init() {
        rows = [CollectionCellIdentifiable]()
        let categories = Resources.Category.allCases
        categories.forEach({ rows.append(NewSpendBaseCategoryCellModel(category: $0.rawValue)) })
    }
}
