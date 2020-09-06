//
//  GNBProductDetailViewModel.swift
//  APPGNB
//
//  Created by Jordi Durán on 05/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBProductDetailViewModel: NSObject {

    // MARK: - Properties
    
    fileprivate let manager = GNBProductDetailManager()
    fileprivate var ratesManager: GNBRatesManager?
    
    fileprivate let currentCurrency: String = "EUR"
    fileprivate var transactionVMList: [GNBTransactionDetailViewModel] = []
    
    
    // MARK: - Config Methods
    
    func resetData() {
        manager.resetData()
        ratesManager = nil
        transactionVMList = []
    }
    
    func setTransactionsList(transactionsList: [GNBProductItem]) {
        manager.setTransactionsList(transactionsList: transactionsList)
    }
    
    func getProductName() -> String {
        return manager.transactionsList.first?.sku ?? "X"
    }
    
    func getCellsVM(withError error: Bool = false) -> [GNBBaseTableViewCellViewModel] {
        var cellsVM = [GNBBaseTableViewCellViewModel]()
        
        // Show the error if we get it from the request
        guard !error else { return [GNBErrorCellViewModel(titleText: "An error has occurred", buttonText: "Try again")] }
        
        // Check if the download was done
        let transactionsList = manager.transactionsList
        guard let ratesManager = self.ratesManager else { return [GNBLoadingCellViewModel()] }
        
        for transactionModel in transactionsList {
            cellsVM.append(GNBProductListItemCellViewModel(titleText: transactionModel.sku,
                                                           subtitleText: "\(transactionModel.amount ?? "") \(transactionModel.currency ?? "")",
                                                           cellActionIdentifier: transactionsList))
        }
        
        return cellsVM
    }
    
    
    // MARK: - Total Amount
    
    func hasToShowTotalAmount() -> Bool {
        return self.ratesManager != nil
    }
    
    func getTotalAmountFormatted() -> String {
        return "30.00€"
    }
    
    
    // MARK: - Fetch Request
    
    func fetchRates(success succeed: @escaping (() -> Void), error: @escaping (() -> Void)) {
        manager.fetchRates(success: { [weak self] in
            self?.processRatesList()
            self?.processTransactionVMList()
            succeed()
            
        }, errorFailure: error)
    }
    
    
    // MARK: - Private methods
    
    /// Set ratesRestModels to ratesManager to process currency exchange
    private func processRatesList() {
        self.ratesManager = nil
        guard let ratesRestModelList = manager.ratesRestModelList else { return }
        
        self.ratesManager = GNBRatesManager(ratesRestModelList: ratesRestModelList, currentCurrency: currentCurrency)
    }
    
    private func processTransactionVMList() {
        transactionVMList.removeAll()
        
        guard let ratesManager = self.ratesManager else { return }
        for transactionModel in manager.transactionsList {
            /// Calculate current currency transaction amount
            if let transactionAmount = ratesManager.calculateCurrentCurrency(forTransaction: transactionModel) {
                transactionVMList.append(GNBTransactionDetailViewModel(transactionModel: transactionModel, currentCurrencyAmount: transactionAmount))
            }
        }
    }
    
}
