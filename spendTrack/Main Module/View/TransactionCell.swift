//
//  TransactionCell.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    static let id = "TransactionCell"
    
    var viewModel: TransactionViewModel? {
        didSet {
            configure()
        }
    }
    
    var spendIcon: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    var categoryLabel: UILabel = {
       let label = UILabel()
        label.text = "Taxi"
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    var spendDate: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "13/10/2022 19:54"
        label.textColor = .lightGray
        return label
    }()
    
    var amountLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.text = "-40$"
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addView(spendIcon)
        addView(categoryLabel)
        addView(spendDate)
        addView(amountLabel)
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        spendIcon.image = viewModel.category.image()
        switch viewModel.category {
        case "🚘":
            categoryLabel.text = "Car"
        case "🛒":
            categoryLabel.text = "Grocceries"
        case "🍹":
            categoryLabel.text = "Entertainment"
        case "👩‍🎓":
            categoryLabel.text = "Education"
        default:
            categoryLabel.text = "Income"
        }
        spendDate.text = viewModel.date
        if viewModel.category == "🤑" {
            amountLabel.text = "+ \(viewModel.amount)"
        } else {
            amountLabel.text = "– \(viewModel.amount)"
        }
    }
}

extension TransactionCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            spendIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            spendIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            spendIcon.widthAnchor.constraint(equalToConstant: 40),
            spendIcon.heightAnchor.constraint(equalToConstant: 40),
            
            categoryLabel.leadingAnchor.constraint(equalTo: spendIcon.trailingAnchor, constant: 5),
            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            
            spendDate.leadingAnchor.constraint(equalTo: spendIcon.trailingAnchor, constant: 5),
            spendDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            amountLabel.centerYAnchor.constraint(equalTo: spendIcon.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
}
