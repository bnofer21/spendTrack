//
//  UIView+Extension.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

extension UIView {
    
    func addView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
