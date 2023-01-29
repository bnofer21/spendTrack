//
//  DataManager.swift
//  spendTrack
//
//  Created by Юрий on 25.12.2022.
//

import Foundation
import UIKit
import CoreData

struct DataManager {
    
    static let shared = DataManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveTransaction(transaction: Transaction, completion: ()->Void) {
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Transaction", in: context) else { return }
        let noteObject = Transaction(entity: entity, insertInto: context)
        noteObject.amount = transaction.amount
        noteObject.category = transaction.category
        noteObject.date = transaction.date
        do {
            try context.save()
            completion()
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func loadTransactions(startIndex: Int, completion: @escaping([Transaction])->Void) {
            let context = appDelegate.persistentContainer.viewContext
            var result = [Transaction]()
            let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
            do {
              result = try context.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error.localizedDescription)")
            }
        if startIndex < result.count-20 {
            result = Array(result[startIndex...startIndex+20])
        } else {
            result = Array(result[startIndex..<result.count])
        }
        completion(result)
    }
    
    func loadBalance(completion: @escaping (Balance)->Void) {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Balance> = Balance.fetchRequest()
        fetchRequest.fetchLimit = 1
        do {
            guard let result: Balance = try context.fetch(fetchRequest).first else {
                createbalanceEntity { balance in
                    completion(balance)
                }
                return
            }
            completion(result)
        } catch let error as NSError {
            print("Could not fetch. \(error.localizedDescription)")
        }
    }
    
    func saveBalance(completion: ()->Void) {
        let context = appDelegate.persistentContainer.viewContext
        do {
            try context.save()
            completion()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func createbalanceEntity(completion: @escaping(Balance)->Void) {
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Balance", in: context) else { return }
        let balanceObject = Balance(entity: entity, insertInto: context)
        do {
            try context.save()
            completion(balanceObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
