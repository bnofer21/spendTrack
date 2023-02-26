//
//  MainViewController.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import UIKit
import Foundation

protocol MainViewInput: AnyObject {
    func updateForSection(_ section: MainSectionModel)
    func updateViewForModel(_ model: InfoModel)
    func showError(_ error: String)
}

protocol MainViewOutput: AnyObject {
    func viewDidLoad()
    func loadMoreTrans(start: Int)
    func saveTrans(amount: Int, category: String, date: Date)
}

final class MainViewController: UIViewController, MainViewInput, Coordinating {
    
    var coordinator: Coordinator?
    
    var output: MainViewOutput?
    var mainSection: MainSectionModel?
    
    var mainView = MainView()
    
    var isLoading = true
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        setTargets()
        output?.viewDidLoad()
        mainView.transactionsTableView.delegate = self
        mainView.transactionsTableView.dataSource = self
    }
    
    func updateForSection(_ section: MainSectionModel) {
        self.mainSection = section
        isLoading = false
        DispatchQueue.main.asyncAfter(deadline: .now()+3) { [weak self] in
            self?.mainView.transactionsTableView.reloadData()
        }
    }
    
    func updateViewForModel(_ model: InfoModel) {
        mainView.model = model
    }
    
    func showError(_ error: String) {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController()
            alertController.title = "Error"
            alertController.message = error
            
            let ok = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(ok)
            self?.present(alertController, animated: true)
        }
    }
    
    private func setTargets() {
        mainView.addMoneyTarget(target: self, action: #selector(addMoney))
        mainView.addSpendTarget(target: self, action: #selector(addSpend))
    }
    
    private func loadMore(startIndex: Int) {
        if !isLoading {
            isLoading.toggle()
            output?.loadMoreTrans(start: startIndex)
        }
    }
    
    @objc private func addMoney() {
        let alert = UIAlertController(title: "Add money", message: "Write amount:", preferredStyle: .alert)
        alert.addTextField { textfield in
            textfield.keyboardType = .numberPad
        }
        let okAction = UIAlertAction(title: "Add", style: .default) { [unowned alert] _ in
            let textfield = alert.textFields![0]
            guard let answer = Int(textfield.text ?? ""), answer > 0 else { return }
            self.output?.saveTrans(amount: answer, category: Resources.Category.income.rawValue, date: Date())
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @objc private func addSpend() {
        coordinator?.eventOccured(with: .newSpend)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let section = mainSection, !section.allLoaded {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            guard let mainSection = mainSection else { return 0 }
            return mainSection.rows.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0, let section = mainSection {
            let model = section.rows[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? BaseTransactionCell else { return UITableViewCell() }
            cell.model = model
            return cell
        } else {
            let model = BaseLoadingCellModel()
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? BaseLoadingCell else { return UITableViewCell() }
            cell.model = model
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let mainSection = mainSection else { return }
        if indexPath.row == mainSection.rows.count-1, !mainSection.allLoaded {
            loadMore(startIndex: indexPath.row+1)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 50 : 70
    }
    
    
}
