//
//  CategoryCollectionView.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

class CategoryCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        register(CategoryCell.self, forCellWithReuseIdentifier: "NewSpendBaseCategoryCell")
    }
}
