//
//  InfoView.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation
import UIKit

class InfoView: UIView, ModelRepresentable {
    var model: ViewIdentifiable? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
    }
    
}
