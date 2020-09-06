//
//  GNBTransactionDetailViewModel.swift
//  APPGNB
//
//  Created by Jordi Durán on 05/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

/// Model with transaction and amount with currency exchange
class GNBTransactionDetailViewModel: NSObject {

    // MARK: - Properties
    
    let transactionModel: GNBProductItem
    let currentCurrencyAmount: Double
    
    
    init(transactionModel: GNBProductItem, currentCurrencyAmount: Double) {
        self.transactionModel = transactionModel
        self.currentCurrencyAmount = currentCurrencyAmount
        super.init()
    }
    
    
    // MARK: - Public functions
    
    func getCurrencyConversionText(targetCurrency: String) -> String {
        guard let transactionAmount = transactionModel.amount,
            let currency = transactionModel.currency else { return "" }
        
        return "\(transactionAmount) \(currency) -> \(targetCurrency)"
    }
    
    
}
