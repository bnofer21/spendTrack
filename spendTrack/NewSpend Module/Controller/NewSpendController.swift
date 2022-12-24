//
//  NewSpendController.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

class NewSpendController: UIViewController {
    
    var newSpendView = NewSpendView()
    
    override func loadView() {
        view = newSpendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setDelegates()
    }
    
    private func setDelegates() {
        newSpendView.categoryCollView.delegate = self
        newSpendView.categoryCollView.dataSource = self
    }
    
    private func setupView() {
        navigationItem.title = "New spending"
    }
}

extension NewSpendController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.id, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        cell.categoryEmoji.text = Resources.Category.allCases[indexPath.row].rawValue
        return cell
    }
    
}

extension NewSpendController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width/4)-1, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
