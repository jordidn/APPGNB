//
//  GNBProductsListViewModel.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBProductsListViewModel: NSObject {

    // MARK: - Properties
    
    fileprivate let manager = GNBProductsListManager()
    
    
    // MARK: - Config Methods
    
    func resetData() {
        manager.resetData()
    }
    
    func getCellsVM(withError error: Bool = false) -> [GNBBaseTableViewCellViewModel] {
        var cellsVM = [GNBBaseTableViewCellViewModel]()
        
        // Show the error if we get it from the request
        guard !error else { return [GNBErrorCellViewModel(titleText: "An error has occurred", buttonText: "Try again")] }
        
        // Check if the download was done
        let productsNameList = manager.getProducts()
        guard !productsNameList.isEmpty else { return [GNBLoadingCellViewModel()] }
        
        // Generate products Cells
        for productName in productsNameList {
            let transactionsList = manager.getTransactions(forProduct: productName)
            cellsVM.append(GNBProductListItemCellViewModel(titleText: productName,
                                                           subtitleText: "\(transactionsList?.count ?? 0) transactions",
                                                           cellActionIdentifier: transactionsList))
        }
        
        return cellsVM
    }

    
    // MARK: - Fetch Request
    
    func fetchProductsList(success succeed: @escaping (() -> Void), error: @escaping (() -> Void)) {
        manager.fetchProductsList(success: succeed, errorFailure: error)
    }
    
}
