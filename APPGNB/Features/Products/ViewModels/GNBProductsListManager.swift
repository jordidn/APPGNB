//
//  GNBProductsListManager.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit
import Moya

class GNBProductsListManager: NSObject {

    // MARK: - Properties
    
    fileprivate var productsListResponse: [GNBProductItem]?
    fileprivate var productsListDictionary: Dictionary<String, [GNBProductItem]> = [:]
    
    let provider = MoyaProvider<GNBProductsListDataSource>()

    
    // MARK: - Config Methods
    
    func resetData() {
        self.productsListResponse = nil
        self.productsListDictionary.removeAll()
    }
    
    
    // MARK: - Config Methods
    
    func getProducts() -> [String] {
        return productsListDictionary.map({ $0.key })
    }
    
    func getTransactions(forProduct productKey: String) -> [GNBProductItem]? {
        return productsListDictionary[productKey]
    }
    
    
    // MARK: - Fetch Request
    
    func fetchProductsList(success succeed: @escaping (() -> Void), errorFailure: @escaping (() -> Void)) {
        provider.request(.productsList) { [weak self] (result) in
            guard let weakSelf = self else { return }

            switch result {
            case .success(let response):
                do {
                    weakSelf.productsListResponse = try response.map(Array<GNBProductItem>.self)
                    weakSelf.processProductsListResponse()
                    succeed()
                } catch {
                    errorFailure()
                }
            case .failure:
                errorFailure()
            }
        }
    }
    
    /// Parse rest response to Dictionary key: `sku`, value: list of transactions
    private func processProductsListResponse() {
        self.productsListDictionary.removeAll()
        
        guard let productsListResponse = self.productsListResponse else { return }
        
        for productItem in productsListResponse {
            guard let sku = productItem.sku else { continue }
            // Append transaction to `sku` if exists, otherwhise create new list
            if var productTransactions = productsListDictionary[sku] {
                productTransactions.append(productItem)
                productsListDictionary.updateValue(productTransactions, forKey: sku)
            } else {
                productsListDictionary[sku] = [productItem]
            }
        }
    }
    
}
