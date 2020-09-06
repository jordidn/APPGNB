//
//  GNBAmountUtils.swift
//  APPGNB
//
//  Created by Jordi Durán on 06/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBAmountUtils: NSObject {

    static func formatAmount(amount: Double, currency: String, decimalNumbers: Int) -> String {
        let symbol = getCurrencySymbol(currency: currency)
        
        return "\(amount) \(symbol)"
    }
    
    static func getCurrencySymbol(currency: String) -> String {
        switch currency {
        case "EUR":
            return "€"
        case "USD":
            return "$"
        default:
            return currency
        }
    }
    
}
