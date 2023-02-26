//
//  BaseLoadingCellModel.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation

final class BaseLoadingCellModel: MainBaseCellModel {
    
    override var cellIdentifier: String {
        return "BaseLoadingCell"
    }
    
    override var cellHeight: Float {
        return 60
    }
    
}
