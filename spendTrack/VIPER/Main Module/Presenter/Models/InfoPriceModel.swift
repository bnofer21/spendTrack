//
//  InfoPriceModel.swift
//  spendTrack
//
//  Created by Юрий on 21.02.2023.
//

import Foundation

final class InfoPriceModel: InfoModel {
    
    var btc: Bitcoin
    
    override var identifier: String {
        return "PriceModel"
    }
    
    var price: String {
        return "\(btc.bpi.usd.rate) $"
    }
    
    var dateUpdated: String {
        return btc.time.updated
    }
    
    init(_ btc: Bitcoin) {
        self.btc = btc
    }
}
