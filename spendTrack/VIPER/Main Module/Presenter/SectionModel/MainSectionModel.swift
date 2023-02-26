//
//  MainSectionModel.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import Foundation

final class MainSectionModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable]
    
    init(_ trans: [Transaction]) {
        rows = [CellIdentifiable]()
        trans.forEach({ rows.append(MainBaseTransCellModel($0)) })
    }
}
