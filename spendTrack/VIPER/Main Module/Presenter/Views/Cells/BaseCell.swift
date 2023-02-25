//
//  BaseCell.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation
import UIKit

class BaseCell: UITableViewCell, CellModelRepressentable {
    
    var model: CellIdentifiable? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
    }
}
