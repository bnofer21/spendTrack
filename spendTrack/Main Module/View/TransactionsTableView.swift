//
//  TransactionsTableView.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

class TransactionsTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.id)
        register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.id)
    }
}
