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
    case loadingCell = "GNBLoadingTableViewCell"
    case errorCell = "GNBErrorTableViewCell"
    case titleDescriptionCell = "SRTitleSubtitleTableViewCell"
    
    
    func getNibName() -> String {
        return self.rawValue
    }
    
    func getHeightCell() -> CGFloat {
        switch self {
        case .errorCell, .titleDescriptionCell:
            return UITableView.automaticDimension
        case .productListItemCell:
            return 80
        case .loadingCell:
            return 90
        }
    }
    
    func getHeightEstimatedCell() -> CGFloat {
        switch self {
        case .titleDescriptionCell:
            return 80
        case .productListItemCell, .loadingCell:
            return 90
        case .errorCell:
            return 100
        }
    }
    
}
