//
//  MainView.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

class MainView: UIView {
    
    var viewModel: MainViewModel? {
        didSet {
            configure()
        }
    }
    
    var btcCoin: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "btc")
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    var btcPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.text = "16380 $"
        return label
    }()
    
    var balanceView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    var descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Your balance"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    var balanceLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40)
        label.text = "16318$"
        return label
    }()
    
    var addMoneyButton: UIButton = {
        let button = UIButton(type: .system)
        let conf = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .large)
        button.setImage(UIImage(systemName: "plus", withConfiguration: conf)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    var spendStats = [UILabel]()
    var stackView = UIStackView()
    
    var addTransactionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add spending", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    var transactionsTableView = TransactionsTableView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
        configureSV()
        createSpendStats()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
    }
    
    private func setupView() {
        addView(btcCoin)
        addView(btcPriceLabel)
        addView(balanceView)
        addView(descriptionLabel)
        addView(balanceLabel)
        addView(addMoneyButton)
        addView(addTransactionButton)
        addView(transactionsTableView)
        addView(stackView)
        backgroundColor = .systemBackground
    }
    
    private func createSpendStats() {
        let statsCount = 2
        for i in 0..<statsCount {
            let stat = UILabel()
            spendStats.append(stat)
            stat.textColor = .white
            stat.font = UIFont.systemFont(ofSize: 14)
            if i == 0 {
                stat.text = "All time spendings: 14814$"
            } else {
                stat.text = "Today spendings: 414$"
            }
            stat.sizeToFit()
            stackView.addArrangedSubview(stat)
        }
    }
    
    private func configureSV() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
    }
    
    func addSpendTarget(target: Any?, action: Selector) {
        addTransactionButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

extension MainView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            btcPriceLabel.trailingAnchor.constraint(equalTo: balanceView.trailingAnchor),
            btcPriceLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            btcCoin.centerYAnchor.constraint(equalTo: btcPriceLabel.centerYAnchor),
            btcCoin.trailingAnchor.constraint(equalTo: btcPriceLabel.leadingAnchor, constant: -5),
            btcCoin.widthAnchor.constraint(equalToConstant: 20),
            btcCoin.heightAnchor.constraint(equalToConstant: 20),
            
            balanceView.topAnchor.constraint(equalTo: btcCoin.bottomAnchor, constant: 5),
            balanceView.centerXAnchor.constraint(equalTo: centerXAnchor),
            balanceView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            balanceView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15),
            
            descriptionLabel.topAnchor.constraint(equalTo: balanceView.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor, constant: 15),
            
            balanceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2),
            balanceLabel.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor, constant: 15),
            
            stackView.bottomAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor, constant: 10),
            
            addMoneyButton.centerYAnchor.constraint(equalTo: balanceView.centerYAnchor),
            addMoneyButton.trailingAnchor.constraint(equalTo: balanceView.trailingAnchor, constant: -15),
            
            addTransactionButton.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: 15),
            addTransactionButton.widthAnchor.constraint(equalTo: balanceView.widthAnchor),
            addTransactionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            transactionsTableView.topAnchor.constraint(equalTo: addTransactionButton.bottomAnchor, constant: 10),
            transactionsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            transactionsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            transactionsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        
    }
}
