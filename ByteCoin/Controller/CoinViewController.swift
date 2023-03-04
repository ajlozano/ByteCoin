//
//  ViewController.swift
//  ByteCoin
//
//  Created by Toni Lozano Fernández on 23/1/23.
//

import UIKit


class CoinViewController: UIViewController {
    
    var coinManager = CoinManager()

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
}

extension CoinViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension CoinViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.FetchCoin(currency: coinManager.currencyArray[row])
    }
}

extension CoinViewController: CoinManagerDelegate {
    func DidUpdateCoinData(_ coinData: CoinData) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coinData.asset_id_quote
            self.bitcoinLabel.text = String(format: "%.2f", coinData.rate)
        }
    }
    
    func DidFailWithError(_ error: Error) {
        print(error)
    }
}

