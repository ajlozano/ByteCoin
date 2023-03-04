//
//  CoinData.swift
//  ByteCoin
//
//  Created by Toni Lozano Fernández on 23/1/23.
//

import Foundation

struct CoinData: Codable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
