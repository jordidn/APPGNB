//
//  GNBAmountUtils.swift
//  APPGNB
//
//  Created by Jordi Durán on 06/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBAmountUtils: NSObject {

    static func formatAmount(amount: Double,
                             currency: String? = nil,
                             numberOfDecimals: Int) -> String {
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = numberOfDecimals
        formatter.minimumFractionDigits = numberOfDecimals
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        
        var ammountFormatted = formatter.string(from: amount as NSNumber) ?? ""
        
        if let currency = currency {
            let symbol = getCurrencySymbol(currency: currency)
            ammountFormatted = "\(ammountFormatted) \(symbol)"
        }
        
        return ammountFormatted
    }
    
    static func getCurrencySymbol(currency: String) -> String {
        switch currency {
        case "EUR":
            return "€"
        case "USD":
            return "$"
        case "GBP":
            return "£"
        case "JPY":
            return "¥"
        case "TRY":
            return "₺"
        case "HKD":
            return "HK$"
        default:
            return currency
        }
    }
    
}
