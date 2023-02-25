//
//  CollectionSectionRowsRepresentable.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation

protocol CollectionSectionRowsRepresentable {
    var rows: [CollectionCellIdentifiable] { get set }
}
