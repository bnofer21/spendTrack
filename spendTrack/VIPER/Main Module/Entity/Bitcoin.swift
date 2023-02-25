//
//  Bitcoin.swift
//  spendTrack
//
//  Created by Юрий on 24.12.2022.
//

import Foundation

struct Bitcoin: Decodable {
    let time: Time
    let bpi: Bpi
}

struct Bpi: Decodable {
    let usd : USD

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

struct USD: Decodable {
    let rate: String
}

struct Time: Decodable {
    let updated: String
}
