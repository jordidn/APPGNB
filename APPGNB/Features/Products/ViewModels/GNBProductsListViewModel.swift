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
        
        guard !error else { return [GNBErrorCellViewModel(titleText: "An error has occurred", buttonText: "Try again")] }
        
        let productsNameList = manager.getProducts()
        guard !productsNameList.isEmpty else { return [GNBLoadingCellViewModel()] }
        for productName in productsNameList {
            cellsVM.append(GNBProductListItemCellViewModel(titleText: productName, cellActionIdentifier: manager.getTransactions(forProduct: productName)))
        }
        
        return cellsVM
    }

    
    // MARK: - Fetch Request
    
    func fetchProductsList(success succeed: @escaping (() -> Void), error: @escaping (() -> Void)) {
        manager.fetchProductsList(success: succeed, errorFailure: error)
    }
    
    
    
}
