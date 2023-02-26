//
//  MainSectionModel.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import Foundation

final class MainSectionModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable]
    var allLoaded: Bool
    
    init(_ trans: [Transaction], allLoaded: Bool) {
        self.allLoaded = allLoaded
        rows = [CellIdentifiable]()
        trans.forEach({ rows.append(MainBaseTransCellModel($0)) })
    }
}
