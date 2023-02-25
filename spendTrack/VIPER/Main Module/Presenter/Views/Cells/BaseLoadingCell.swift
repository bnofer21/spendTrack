//
//  BaseLoadingCell.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import UIKit

class BaseLoadingCell: BaseCell {
    
    var activityIndicator = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func updateViews() {
        guard let model = model as? BaseLoadingCellModel else { return }
        activityIndicator.startAnimating()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

