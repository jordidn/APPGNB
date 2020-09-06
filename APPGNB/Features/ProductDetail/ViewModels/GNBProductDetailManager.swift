//
//  GNBProductDetailManager.swift
//  APPGNB
//
//  Created by Jordi Durán on 05/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit
import Moya

class GNBProductDetailManager: NSObject {

    // MARK: - Properties
    
    fileprivate (set) var transactionsList: [GNBProductItem] = []
    fileprivate (set) var ratesRestModelList: [GNBRateModel]?
    
    let provider = MoyaProvider<GNBProductDetailDataSource>()
    
    
    // MARK: - Config Methods
    
    func resetData() {
        self.ratesRestModelList = nil
    }
    
    func setTransactionsList(transactionsList: [GNBProductItem]) {
        self.transactionsList = transactionsList
    }
    
    
    // MARK: - Fetch Request
    
    func fetchRates(success succeed: @escaping (() -> Void), errorFailure: @escaping (() -> Void)) {
        provider.request(.rates) { [weak self] (result) in
            guard let weakSelf = self else { return }

            switch result {
            case .success(let response):
                do {
                    weakSelf.ratesRestModelList = try response.map(Array<GNBRateModel>.self)
                    succeed()
                } catch {
                    errorFailure()
                }
            case .failure:
                errorFailure()
            }
        }
    }
    
}
