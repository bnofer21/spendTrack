//
//  PriceLoader.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import Foundation

protocol PriceLoaderInteface {
    func loadPrice(completion: @escaping(Bitcoin?, String?) -> Void)
}

final class PriceLoader: PriceLoaderInteface {
    
    func loadPrice(completion: @escaping (Bitcoin?, String?) -> Void) {
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            guard let data = data else {
                completion(nil, "No data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Bitcoin.self, from: data)
                completion(result, nil)
            } catch let error as NSError {
                completion(nil, error.localizedDescription)
            }
        }.resume()
    }
}
