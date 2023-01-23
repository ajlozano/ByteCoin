//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol CoinManagerDelegate {
    func DidUpdateCoinData(_ coinValueString: String)
    func DidFailWithError(_ error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "745B3DBB-2FCF-4E66-AEAA-4F324EFE5D8D"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?

    func FetchCoin(currency: String) {
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(url)
        PerformRequest(with: url)
    }
    
    func PerformRequest(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: url) { data, response, error in
                if (error != nil) {
                    self.delegate?.DidFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let coinValue = parseJSON(coinData: safeData) {
                        let coinValueString = String(format: "%.2f", coinValue)
                        print(coinValueString)
                        self.delegate?.DidUpdateCoinData(coinValueString)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func parseJSON(coinData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(CoinData.self, from: coinData)
            return decoderData.rate
        } catch {
            print(error)
            return nil
        }
    }
    
    func GetCoinPrice(for currency: String) {
        
    }
}
