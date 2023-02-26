//
//  NewSpendSectionModel.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation

class NewSpendSectionModel: CollectionSectionRowsRepresentable {
    var rows: [CollectionCellIdentifiable]
    
    init(_ categories: [String]) {
        rows = [CollectionCellIdentifiable]()
        categories.forEach{ rows.append(NewSpendBaseCategoryCellModel($0)) }
    }
}
