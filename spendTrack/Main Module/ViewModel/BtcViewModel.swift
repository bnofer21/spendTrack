//
//  MainViewModel.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import Foundation

struct BtcViewModel {
    
    var btc: Bitcoin
    
    var price: String {
        return btc.bpi.usd.rate
    }
    
    init(btc: Bitcoin) {
        self.btc = btc
    }
}
