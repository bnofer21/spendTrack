//
//  MainController.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

class MainController: UIViewController {
    
    var transactions = [Transaction]()
    var mainView = MainView()
    
    init(transactions: [Transaction]) {
        self.transactions = transactions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
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
    }
    
    func updateData() {
        mainView.transactionsTableView.reloadData()
    }
    
    @objc func newSpending() {
        let vc = NewSpendController()
        navigationController?.pushViewController(vc, animated: true)
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

