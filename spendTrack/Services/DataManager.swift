//
//  DataManager.swift
//  spendTrack
//
//  Created by Юрий on 25.12.2022.
//

import Foundation
import UIKit
import CoreData

protocol DataManagerInterface {
    func loadTrans(startIndex: Int, completion: @escaping ([Transaction]?, String?) -> Void)
    func loadBalance(completion: @escaping (Balance?, String?) -> Void)
    func saveTrans(amount: Int, category: String, date: Date, completion: @escaping (String?) -> Void)
}

final class DataManager: DataManagerInterface {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func loadTrans(startIndex: Int, completion: @escaping ([Transaction]?, String?) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        var result = [Transaction]()
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        do {
            result = try context.fetch(fetchRequest)
        } catch let error as NSError {
            completion(nil, error.localizedDescription)
        }
        result = result.sorted(by: { $0.date! > $1.date! })
        if startIndex < result.count-20 {
            result = Array(result[startIndex...startIndex+20])
        } else {
            result = Array(result[startIndex..<result.count])
        }
        completion(result, nil)
    }
    
    func loadBalance(completion: @escaping (Balance?, String?) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Balance> = Balance.fetchRequest()
        fetchRequest.fetchLimit = 1
        do {
            guard let result: Balance = try context.fetch(fetchRequest).first else {
                createbalanceEntity { balance, error in
                    if let error = error {
                        completion(nil, error)
                    }
                    completion(balance, nil)
                    print("created new balance")
                }
                return
            }
            completion(result, nil)
        } catch let error as NSError {
            completion(nil, error.localizedDescription)
        }
    }
    
    func saveTrans(amount: Int, category: String, date: Date, completion: @escaping (String?) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Transaction", in: context) else {
            completion("Error creating entity")
            return
        }
        let noteObject = Transaction(entity: entity, insertInto: context)
        let calendar = Calendar.current
        let type: Resources.TransactionType = category == "🤑" ? .income : .spend
        noteObject.amount = Int64(amount)
        noteObject.category = category
        noteObject.date = date
        saveBalance(amount: Int(noteObject.amount), type: type, today: calendar.isDateInToday(noteObject.date!)) { balance, error in
            if let error = error {
                completion(error)
            } else {
                do {
                    try context.save()
                    completion(nil)
                } catch let error as NSError {
                    completion(error.localizedDescription)
                }
            }
        }
    }
    
    private func saveBalance(amount: Int, type: Resources.TransactionType, today: Bool, completion: @escaping (Balance?, String?) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        loadBalance { balance, error in
            if let error = error {
                completion(nil, error)
            } else if let balance = balance {
                if type == .income {
                    balance.setValue(balance.currentBalance + Int64(amount), forKey: "currentBalance")
                } else {
                    balance.setValue(balance.currentBalance - Int64(amount), forKey: "currentBalance")
                    balance.setValue(balance.spendAllTime + Int64(amount), forKey: "spendAllTime")
                    if today { balance.setValue(balance.spendToday + Int64(amount), forKey: "spendToday")}
                }
                do {
                    try context.save()
                    completion(balance, nil)
                } catch let error as NSError {
                    completion(nil, error.localizedDescription)
                }
            }
        }
    }
    
    private func createbalanceEntity(completion: @escaping(Balance?, String?)->Void) {
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Balance", in: context) else {
            completion(nil, "Error creating Balance entity")
            return 
        }
        let balanceObject = Balance(entity: entity, insertInto: context)
        do {
            try context.save()
            completion(balanceObject, nil)
        } catch let error as NSError {
            completion(nil, error.localizedDescription)
        }
    }
}
