//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Toni Lozano Fernández on 23/1/23.
//

import Foundation
import CoreLocation

protocol CoinManagerDelegate {
    func DidUpdateCoinData(_ coinData: CoinData)
    func DidFailWithError(_ error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "745B3DBB-2FCF-4E66-AEAA-4F324EFE5D8D"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?

    func FetchCoin(currency: String) {
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
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
                    if let coinDataValues = self.parseJSON(coinData: safeData) {
                        self.delegate?.DidUpdateCoinData(coinDataValues)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func parseJSON(coinData: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(CoinData.self, from: coinData)
            return decoderData
        } catch {
            print(error)
            return nil
        }
    }
    
    func GetCoinPrice(for currency: String) {
        
    }
}
