//
//  AddSpendButton.swift
//  spendTrack
//
//  Created by Юрий on 25.12.2022.
//

import UIKit

class AddSpendButton: UIButton {
    
    override var isEnabled: Bool {
        willSet {
            if newValue {
                backgroundColor = .systemBlue
            } else {
                backgroundColor = #colorLiteral(red: 0.918738544, green: 0.9187384844, blue: 0.9187384844, alpha: 1)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.918738544, green: 0.9187384844, blue: 0.9187384844, alpha: 1)
        setTitle("Save spending", for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 11
        isEnabled = false
    }
}
