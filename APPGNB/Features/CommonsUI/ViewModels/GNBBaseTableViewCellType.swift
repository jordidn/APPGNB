//
//  GNBBaseTableViewCellType.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

enum GNBBaseTableViewCellType: String {

    case productListItemCell = "GNBProductListItemTableViewCell"
    case productDetailItem = "GNBProductDetailItemTableViewCell"
    case loadingCell = "GNBLoadingTableViewCell"
    case errorCell = "GNBErrorTableViewCell"
    
    
    func getNibName() -> String {
        return self.rawValue
    }
    
    func getHeightCell() -> CGFloat {
        switch self {
        case .errorCell:
            return UITableView.automaticDimension
        case .productListItemCell, .productDetailItem:
            return 80
        case .loadingCell:
            return 90
        }
    }
    
    func getHeightEstimatedCell() -> CGFloat {
        switch self {
        case .productListItemCell, .productDetailItem, .loadingCell:
            return 90
        case .errorCell:
            return 100
        }
    }
    
}
