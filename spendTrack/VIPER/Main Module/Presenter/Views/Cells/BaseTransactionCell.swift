//
//  BaseTransactionCell.swift
//  spendTrack
//
//  Created by ะฎัะธะน on 24.12.2022.
//

import UIKit

class BaseTransactionCell: BaseCell {
    
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
    
    internal override func updateViews() {
        guard let model = model as? MainBaseTransCellModel else { return }
        spendIcon.image = model.category.image()
        
        switch model.category {
        case "๐":
            categoryLabel.text = "Car"
        case "๐":
            categoryLabel.text = "Grocceries"
        case "๐น":
            categoryLabel.text = "Entertainment"
        case "๐ฉโ๐":
            categoryLabel.text = "Education"
        default:
            categoryLabel.text = "Income"
        }
        spendDate.text = model.date
        if model.category == "๐ค" {
            amountLabel.text = "+ \(model.amount)$"
        } else {
            amountLabel.text = "โ \(model.amount)$"
        }
    }
    
}

extension BaseTransactionCell {
    
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
