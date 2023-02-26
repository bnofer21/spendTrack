//
//  CategoryCell.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

class CategoryCell: BaseCollectionCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.layer.borderColor = UIColor.systemBlue.cgColor
            } else {
                contentView.layer.borderColor = #colorLiteral(red: 0.918738544, green: 0.9187384844, blue: 0.9187384844, alpha: 1).cgColor
            }
        }
    }
    
    var categoryEmoji: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateView() {
        guard let model = model as? NewSpendBaseCategoryCellModel else { return }
        categoryEmoji.text = model.category
    }
    
    private func setupView() {
        addView(categoryEmoji)
        categoryEmoji.frame = bounds
        backgroundColor = .white
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = #colorLiteral(red: 0.918738544, green: 0.9187384844, blue: 0.9187384844, alpha: 1).cgColor
        contentView.layer.cornerRadius = 10
    }
}
