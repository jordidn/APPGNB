//
//  GNBRatesManager.swift
//  APPGNB
//
//  Created by Jordi Durán on 05/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBRatesManager: NSObject {

    // MARK: - Properties
    
    fileprivate var ratesRestModelList: [GNBRateModel]
    fileprivate let currentCurrency: String
    fileprivate let defaultRate: Double = 1
    
    fileprivate var currencyExchangeCache: Dictionary<String, Double> = [:]
    
    
    init(ratesRestModelList: [GNBRateModel], currentCurrency: String) {
        self.ratesRestModelList = ratesRestModelList
        self.currentCurrency = currentCurrency
        super.init()
    }
    
    
    // MARK: - Config Methods
    
    func calculateCurrentCurrency(forTransaction transactionModel: GNBProductItem) -> Double? {
        guard let transactionCurrency = transactionModel.currency,
            let originalAmountString = transactionModel.amount,
            let originalAmount = Double(originalAmountString) else { return nil }
        
        return currencyExchange(originalCurrency: transactionCurrency,
                                targetCurrency: currentCurrency,
                                originalAmount: originalAmount)
    }
    
    
    /// Temporary variable to search for currency exchange
    private var revisedCurrency: Set<String> = Set<String>()
    
    
    private func currencyExchange(originalCurrency: String, targetCurrency: String, originalAmount: Double) -> Double {
        guard originalCurrency != currentCurrency else { return originalAmount }
        self.revisedCurrency.removeAll()
        
        // Consulted currency exchange previously
        if let rate = self.currencyExchangeCache[originalCurrency] {
            return originalAmount * rate
            
        } else if let rate = getRate(originalCurrency: originalCurrency, targetCurrency: targetCurrency, defaultRate: defaultRate) {
            
            // Save currency exchange for future requests
            self.currencyExchangeCache[originalCurrency] = rate
            
            return originalAmount * rate
        }
        
        return originalAmount
    }
    
    private func getRate(originalCurrency: String, targetCurrency: String, defaultRate: Double) -> Double? {
        // Direct conversion
        if let rate = getRateBetween(originalCurrency: originalCurrency, targetCurrency: targetCurrency) {
            return rate * defaultRate
            
        // Search another conversion
        } else {
            revisedCurrency.insert(originalCurrency)
            for rateModel in ratesRestModelList {
                guard let fromRate = rateModel.from, let toRate = rateModel.to, let rateValue = rateModel.rate else { continue }
                
                if originalCurrency == fromRate, !revisedCurrency.contains(toRate) {
                    if let rateDouble = Double(rateValue) {
                        if let rate = getRate(originalCurrency: toRate, targetCurrency: targetCurrency, defaultRate: defaultRate * rateDouble) {
                            return rate
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    private func getRateBetween(originalCurrency: String, targetCurrency: String) -> Double? {
        for rateModel in ratesRestModelList {
            if originalCurrency == rateModel.from && targetCurrency == rateModel.to, let rate = rateModel.rate {
                return Double(rate)
            }
        }
        return nil
    }
    
}
