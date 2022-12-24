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
    
    func loadTransactions(completion: @escaping([Transaction])->Void) {
            let context = appDelegate.persistentContainer.viewContext
            var result = [Transaction]()
            let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
            do {
              result = try context.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error.localizedDescription)")
            }
            result = result.sorted(by: { $0.date! > $1.date! })
            completion(result)
        }
}
