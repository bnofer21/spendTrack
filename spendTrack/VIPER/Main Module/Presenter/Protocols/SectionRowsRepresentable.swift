//
//  SectionRowsRepresentable.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import Foundation

protocol SectionRowsRepresentable {
    var rows: [CellIdentifiable] { get set }
}
