//
//  GNBProductsList.swift
//  APPGNB
//
//  Created by Jordi Durán on 05/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import Foundation

struct GNBProductsListResponse<Array: Codable>: Codable {
  let data: [GNBProductItem]
}

struct GNBProductList<T: Codable>: Codable {
  let results: [T]
}


class GNBProductItem: Codable {

    var sku: String?
    var amount: String?
    var currency: String?
    
    
}
