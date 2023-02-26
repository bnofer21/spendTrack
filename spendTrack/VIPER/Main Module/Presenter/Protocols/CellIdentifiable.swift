//
//  CellIdentifiable.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import Foundation

protocol CellIdentifiable {
    var cellIdentifier: String { get }
    var cellHeight: Float { get }
}
