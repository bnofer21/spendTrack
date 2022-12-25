//
//  MainController.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

class MainController: UIViewController {
    
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
        mainView.balanceViewmodel = BalanceViewModel(balance: balance, transactions: transactions)
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupView()
        setTargets()
        getPrice()
    }
    
    private func getPrice() {
        Network.shared.getPrice { btc in
            self.mainView.viewModel = BtcViewModel(btc: btc)
        }
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
        transactions = transactions.sorted(by: { $0.date! > $1.date! })
        mainView.balanceViewmodel = BalanceViewModel(balance: balance, transactions: transactions)
        mainView.transactionsTableView.reloadData()
    }
    
    private func updateBalanceAndTransactions(amount: Int) {
        balance.currentBalance += Int64(amount)
        // add transaction income
        let trans = Transaction(entity: Transaction.entity(), insertInto: nil)
        trans.type = Resources.TransactionType.income.rawValue
        trans.amount = Int64(amount)
        trans.date = Date.now
        trans.category = Resources.Category.income.rawValue
        DataManager.shared.saveTransaction(transaction: trans) {
            transactions.insert(trans, at: 0)
            updateData()
        }
        DataManager.shared.saveBalance {
            mainView.balanceViewmodel = BalanceViewModel(balance: balance, transactions: transactions)
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.id, for: indexPath) as? TransactionCell else { return UITableViewCell() }
        cell.viewModel = TransactionViewModel(transaction: transactions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
}

