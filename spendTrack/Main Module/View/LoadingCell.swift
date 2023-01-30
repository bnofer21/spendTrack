//
//  LoadingCell.swift
//  spendTrack
//
//  Created by Юрий on 28.12.2022.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    static let id = "LoadingCell"
    
    var activityIndicator = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addView(activityIndicator)
        separatorInset = UIEdgeInsets(top: 0, left: 400, bottom: 0, right: 0)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
