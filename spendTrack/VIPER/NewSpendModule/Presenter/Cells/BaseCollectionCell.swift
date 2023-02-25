//
//  CategoryBaseCell.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation
import UIKit

class BaseCollectionCell: UICollectionViewCell, CollectionCellModelRepresentable {
    var model: CollectionCellIdentifiable? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
    }
}
