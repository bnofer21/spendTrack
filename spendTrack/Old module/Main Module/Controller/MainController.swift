//
//  MainController.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

class MainController: UIViewController {
    
    var isLoading = false
    var isLastTrans = false
    var transactions: [Transaction]
    var balance: Balance
    var mainView = MainView()
    
    init(transactions: [Transaction], balance: Balance) {
        self.balance = balance
        self.transactions = transactions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
//        mainView.balanceViewmodel = BalanceViewModel(balance: balance, transactions: transactions)
//        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupView()
        setTargets()
        getPrice()
    }
    
    private func getPrice() {
//        Network.shared.getPrice { btc in
//            self.mainView.viewModel = BtcViewModel(btc: btc)
//        }
    }
    
    private func setDelegates() {
        mainView.transactionsTableView.delegate = self
        mainView.transactionsTableView.dataSource = self
    }
    
    private func setupView() {
        navigationItem.title = "Main Screen"
    }
    
    private func setTargets() {
        mainView.addSpendTarget(target: self, action: #selector(newSpending))
        mainView.addMoneyTarget(target: self, action: #selector(addMoney))
    }
    
    func updateData() {
//        transactions = transactions.sorted(by: { $0.date! > $1.date! })
//        mainView.balanceViewmodel = BalanceViewModel(balance: balance, transactions: transactions)
//        mainView.transactionsTableView.reloadData()
    }
    
    private func updateBalanceAndTransactions(amount: Int) {
        balance.currentBalance += Int64(amount)
        // add transaction income
        let trans = Transaction(entity: Transaction.entity(), insertInto: nil)
        trans.type = Resources.TransactionType.income.rawValue
        trans.amount = Int64(amount)
        trans.date = Date.now
        trans.category = Resources.Category.income.rawValue
//        DataManager.shared.saveTransaction(transaction: trans) {
//            transactions.insert(trans, at: 0)
//            updateData()
//        }
//        DataManager.shared.saveBalance {
//            mainView.balanceViewmodel = BalanceViewModel(balance: balance, transactions: transactions)
//        }
    }
    
    private func loadMoreData(startIndex: Int) {
        if !isLoading, !isLastTrans {
//            DispatchQueue.global().asyncAfter(deadline: .now()+1) {
//                DataManager.shared.loadTransactions(startIndex: startIndex) { transactions in
//                    if transactions.count == 20 {
//                        self.isLoading.toggle()
//                    } else {
//                        self.isLastTrans = true
//                    }
//                    self.transactions.append(contentsOf: transactions)
//                    self.transactions.sort(by: { $0.date! > $1.date! })
//                }
//                DispatchQueue.main.async {
//                    self.mainView.transactionsTableView.reloadData()
//                    self.isLoading = false
//                }
//            }
        }
    }
    
    @objc func newSpending() {
        let vc = NewSpendController(balance: balance)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addMoney() {
        let alert = UIAlertController(title: "Add money", message: "Write amount:", preferredStyle: .alert)
        alert.addTextField { textfield in
            textfield.keyboardType = .numberPad
        }
        let okAction = UIAlertAction(title: "Add", style: .default) { [unowned alert] _ in
            let textfield = alert.textFields![0]
            guard let answer = textfield.text, Int(answer) ?? 0 > 0 else { return }
            self.updateBalanceAndTransactions(amount: Int(answer) ?? 0)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    


}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if transactions.count > 10 {
            return 2
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return transactions.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.id, for: indexPath) as? TransactionCell else { return UITableViewCell() }
//            cell.viewModel = TransactionViewModel(transaction: transactions[indexPath.row])
//            return cell
//        } else {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.id, for: indexPath) as? LoadingCell, transactions.count > 10 else { return UITableViewCell() }
//            if isLastTrans {
//                cell.activityIndicator.isHidden = true
//            } else {
//                cell.isHidden = false
//                cell.activityIndicator.startAnimating()
//            }
//            return cell
//        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == transactions.count-1, !isLoading {
            loadMoreData(startIndex: indexPath.row+1)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 50
        } else {
            if isLastTrans {
                return 0
            } else {
                return 70
            }
        }
    }
    
}

