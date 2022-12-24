//
//  NewSpendController.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

class NewSpendController: UIViewController {
    
    var newSpendView = NewSpendView()
    var transaction = Transaction(entity: Transaction.entity(), insertInto: nil)
    
    override func loadView() {
        view = newSpendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setDelegates()
        setTargets()
    }
    
    private func setDelegates() {
        newSpendView.categoryCollView.delegate = self
        newSpendView.categoryCollView.dataSource = self
        newSpendView.amountField.delegate = self
    }
    
    private func setTargets() {
        newSpendView.createSaveTarget(target: self, action: #selector(saveTransaction))
        newSpendView.createHideKB(target: self, action: #selector(hideKB))
    }
    
    private func setupView() {
        navigationItem.title = "New spending"
    }
    
    private func checkAllFields() {
        guard transaction.amount > 0,
              let _ = transaction.date,
              let _ = transaction.category
        else {
            newSpendView.saveSpendingButton.isEnabled = false
            return
        }
        newSpendView.saveSpendingButton.isEnabled = true
        
    }
    
    @objc func hideKB() {
        newSpendView.endEditing(true)
        checkAllFields()
    }
    
    @objc func saveTransaction() {
        DataManager.shared.saveTransaction(transaction: transaction) {
            if let rootvc = navigationController?.viewControllers.first as? MainController {
                rootvc.transactions.insert(transaction, at: 0)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        transaction.category = Resources.Category.allCases[indexPath.row].rawValue
        checkAllFields()
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

extension NewSpendController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        transaction.type = Int64(Resources.TransactionType.spend.rawValue)
        transaction.amount = Int64(text) ?? 0
        transaction.date = Date.now
        checkAllFields()
    }
}
