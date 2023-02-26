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
    func saveTrans(amount: Int, category: String, date: Date)
    func showSpendVC()
}

final class MainViewController: UIViewController, MainViewInput {
    
    var output: MainViewOutput?
    var mainSection: MainSectionModel?
    
    var mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTargets()
        output?.viewDidLoad()
        mainView.transactionsTableView.delegate = self
        mainView.transactionsTableView.dataSource = self
    }
    
    func updateForSection(_ section: MainSectionModel) {
        self.mainSection = section
        DispatchQueue.main.async { [weak self] in
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
        output?.showSpendVC()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let section = mainSection, section.rows.count > 10 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let mainSection = mainSection, section == 0 {
            return mainSection.rows.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let section = mainSection {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return mainSection == nil ? 60 : 50
    }
    
    
}
