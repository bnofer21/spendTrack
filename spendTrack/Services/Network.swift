//
//  Network.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import Foundation

struct Network {
    
    static let shared = Network()
    
    func getPrice(completion: @escaping(Bitcoin)->Void) {
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Bitcoin.self, from: data)
                completion(result)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
