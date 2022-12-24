//
//  MainController.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

class MainController: UIViewController {
    
    var mainView = MainView()
    
    override func loadView() {
        mainView.viewModel = MainViewModel()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupView()
        setTargets()
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
    
    @objc func newSpending() {
        let vc = NewSpendController()
        navigationController?.pushViewController(vc, animated: true)
    }
    


}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.id, for: indexPath) as? TransactionCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
}

