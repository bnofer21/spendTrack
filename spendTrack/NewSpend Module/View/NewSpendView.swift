//
//  NewSpendView.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import UIKit

class NewSpendView: UIView {
    
    var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    var amountField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.textColor = .black
        tf.layer.cornerRadius = 11
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.backgroundColor = #colorLiteral(red: 0.918738544, green: 0.9187384844, blue: 0.9187384844, alpha: 1)
        return tf
    }()
    
    var saveAmountButton: UIButton = {
       let button = UIButton()
        button.setTitle("That's it", for: .normal)
        button.layer.cornerRadius = 11
        button.backgroundColor = #colorLiteral(red: 0.918738544, green: 0.9187384844, blue: 0.9187384844, alpha: 1)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Category"
        label.textColor = .black
        return label
    }()
    
    var categoryCollView = CategoryCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Date"
        label.textColor = .black
        return label
    }()
    
    var dateField: UIDatePicker = {
        let field = UIDatePicker()
        return field
    }()
    
    var saveSpendingButton = AddSpendButton()
    
    var viewArray = [UIView]()
    var insideViewArray = [UIView]()
    var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
        setConstraintsInsideViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        let count = 3
        for i in 0..<count {
            let view = UIView()
            let view2 = UIView()
            view.addView(view2)
            view2.backgroundColor = .white
            view2.layer.cornerRadius = 30
            insideViewArray.append(view2)
            view.layer.cornerRadius = 30
            switch i {
            case 0:
                view.addView(amountLabel)
                view.addView(amountField)
                view.addView(saveAmountButton)
            case 1:
                view.addView(categoryLabel)
                view.addView(categoryCollView)
            default:
                view.addView(dateLabel)
                view.addView(dateField)
            }
            view.backgroundColor = #colorLiteral(red: 0.918738544, green: 0.9187384844, blue: 0.9187384844, alpha: 1)
            viewArray.append(view)
            stackView.addArrangedSubview(view)
        }
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
    }
    
    private func setupView() {
        backgroundColor = .white
        addView(stackView)
        addView(amountField)
        addView(amountLabel)
        addView(categoryCollView)
        addView(categoryLabel)
        addView(dateLabel)
        addView(dateField)
        addView(saveSpendingButton)
        createViews()
        configureStackView()
    }
    
    func createSaveTarget(target: Any?, action: Selector) {
        saveSpendingButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func createHideKB(target: Any?, action: Selector) {
        saveAmountButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
}

extension NewSpendView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            amountLabel.topAnchor.constraint(equalTo: insideViewArray[0].topAnchor, constant: 25),
            amountLabel.leadingAnchor.constraint(equalTo: insideViewArray[0].leadingAnchor, constant: 25),
            
            amountField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 10),
            amountField.leadingAnchor.constraint(equalTo: insideViewArray[0].leadingAnchor, constant: 25),
            amountField.trailingAnchor.constraint(equalTo: insideViewArray[0].trailingAnchor, constant: -25),
            amountField.heightAnchor.constraint(equalToConstant: 50),
            
            saveAmountButton.centerXAnchor.constraint(equalTo: amountField.centerXAnchor),
            saveAmountButton.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 10),
            saveAmountButton.heightAnchor.constraint(equalTo: amountField.heightAnchor),
            saveAmountButton.widthAnchor.constraint(equalTo: amountField.widthAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: insideViewArray[1].topAnchor, constant: 25),
            categoryLabel.leadingAnchor.constraint(equalTo: insideViewArray[1].leadingAnchor, constant: 25),
            
            categoryCollView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            categoryCollView.leadingAnchor.constraint(equalTo: insideViewArray[1].leadingAnchor, constant: 25),
            categoryCollView.trailingAnchor.constraint(equalTo: insideViewArray[1].trailingAnchor, constant: -25),
            categoryCollView.bottomAnchor.constraint(equalTo: insideViewArray[1].bottomAnchor, constant: -25),
            
            dateLabel.topAnchor.constraint(equalTo: insideViewArray[2].topAnchor, constant: 25),
            dateLabel.leadingAnchor.constraint(equalTo: insideViewArray[2].leadingAnchor, constant: 25),
            
            dateField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            dateField.centerXAnchor.constraint(equalTo: insideViewArray[2].centerXAnchor),
            
            saveSpendingButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            saveSpendingButton.centerXAnchor.constraint(equalTo: viewArray[2].centerXAnchor),
            saveSpendingButton.widthAnchor.constraint(equalTo: viewArray[2].widthAnchor),
            saveSpendingButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    private func setConstraintsInsideViews() {
        for i in 0..<insideViewArray.count {
            NSLayoutConstraint.activate([
                insideViewArray[i].centerXAnchor.constraint(equalTo: viewArray[i].centerXAnchor),
                insideViewArray[i].centerYAnchor.constraint(equalTo: viewArray[i].centerYAnchor),
                insideViewArray[i].heightAnchor.constraint(equalTo: viewArray[i].heightAnchor, multiplier: 0.91),
                insideViewArray[i].widthAnchor.constraint(equalTo: viewArray[i].widthAnchor, multiplier: 0.95),
            ])
        }
    }
}

