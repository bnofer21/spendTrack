//
//  NewSpendViewController.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation
import UIKit

protocol NewSpendViewInput: AnyObject {
    func updateForSection(_ section: NewSpendSectionModel)
    func dismissVC()
    func showError(_ error: String)
}

protocol NewSpendViewOutput {
    func viewDidLoad()
    func saveTrans(amount: Int, category: String, date: Date)
}

final class NewSpendViewController: UIViewController, NewSpendViewInput, Coordinating {
    
    var coordinator: Coordinator?
    var output: NewSpendViewOutput?
    var spendSection: NewSpendSectionModel?
    
    var category: String?
    
    var newSpendView = NewSpendView()
    
    override func loadView() {
        view = newSpendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        targets()
        delegates()
        output?.viewDidLoad()
        title = "Add"
    }
    
    internal func updateForSection(_ section: NewSpendSectionModel) {
        self.spendSection = section
        DispatchQueue.main.async { [weak self] in
            self?.newSpendView.categoryCollView.reloadData()
        }
    }
    
    internal func dismissVC() {
        coordinator?.eventOccured(with: .didAddSpend)
    }
    
    internal func showError(_ error: String) {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController()
            alertController.title = "Error"
            alertController.message = error
            
            let ok = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(ok)
            self?.present(alertController, animated: true)
        }
    }
    
    private func targets() {
        newSpendView.createSaveTarget(target: self, action: #selector(saveTrans))
        newSpendView.createHideKB(target: self, action: #selector(hideKeyboard))
    }
    
    private func delegates() {
        newSpendView.categoryCollView.delegate = self
        newSpendView.categoryCollView.dataSource = self
        newSpendView.amountField.delegate = self
    }
    
    private func checkFields() {
        guard let text = newSpendView.amountField.text else { return }
        if let _ = category, let _ = Int(text) {
            newSpendView.saveSpendingButton.isEnabled = true
        } else {
            newSpendView.saveSpendingButton.isEnabled = false
        }
    }
    
    @objc private func saveTrans() {
        guard let amount = Int(newSpendView.amountField.text ?? "") else { return }
        guard let category = category else { return }
        let date = newSpendView.dateField.date
        output?.saveTrans(amount: amount, category: category, date: date)
    }
    
    @objc private func hideKeyboard() {
        newSpendView.endEditing(true)
        checkFields()
    }
    
}

extension NewSpendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let spendSection = spendSection {
            return spendSection.rows.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let spendSection = spendSection {
            let model = spendSection.rows[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.cellIdentifier, for: indexPath) as? BaseCollectionCell else {
                return UICollectionViewCell() }
            cell.model = model
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = spendSection?.rows[indexPath.row] as? NewSpendBaseCategoryCellModel else { return }
        category = model.category
        hideKeyboard()
    }
    
}

extension NewSpendViewController: UICollectionViewDelegateFlowLayout {
    
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

extension NewSpendViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkFields()
    }
}
