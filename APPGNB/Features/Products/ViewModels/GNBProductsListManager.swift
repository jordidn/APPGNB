//
//  GNBProductsListManager.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBProductsListManager: NSObject {

    // MARK: - Properties
    
    fileprivate (set) var productsList: [Any]?

    
    // MARK: - Config Methods
    
    func resetData() {
        self.productsList = nil
    }
    
    
    // MARK: - Fetch Request
    
    func fetchProductsList(success succeed: @escaping (() -> Void), error: @escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            error()
        }
        
    }
    
}
