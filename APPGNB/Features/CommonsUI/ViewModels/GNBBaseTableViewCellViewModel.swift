//
//  GNBBaseTableViewCellViewModel.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBBaseTableViewCellViewModel: NSObject {

    // MARK: - Properties
    
    private (set) var cellType: GNBBaseTableViewCellType
    
    var titleText: String?
    var showSeparator: Bool = true
    
    var cellHeight: CGFloat?
    // This var defines the action to be performed
    var cellActionIdentifier: Any?
    
    
    init(cellType: GNBBaseTableViewCellType) {
        self.cellType = cellType
    }
    
}


extension GNBBaseTableViewCellViewModel {
    
    /// Configure the table view
    static func configureTable(_ tableView: UITableView, bounces: Bool = false) {
        tableView.bounces = bounces
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    /// Configure the table view for TJBaseTableViewCellType
    static func registerTableViewCells(_ tableView: UITableView, cellsVM: [GNBBaseTableViewCellViewModel]) {
        let nibNames: Set<GNBBaseTableViewCellType> = Set(cellsVM.map({ $0.cellType }))
        for nibName in nibNames {
            tableView.gnbRegisterCell(nibName: nibName)
        }
    }
    
    /// Get height of a index cell
    static func getCellHeight(cellsVM: [GNBBaseTableViewCellViewModel], index: Int) -> CGFloat {
        guard let cellVM = getCellVM(atIndex: index, forCellsVM: cellsVM) else { return UITableView.automaticDimension }
        if let cellHeight = cellVM.cellHeight { return cellHeight }
        return cellVM.cellType.getHeightCell()
    }
    
    /// Get estimated height of a index cell
    static func getCellEstimatedHeight(cellsVM: [GNBBaseTableViewCellViewModel], index: Int) -> CGFloat {
        guard let cellVM = getCellVM(atIndex: index, forCellsVM: cellsVM) else { return UITableView.automaticDimension }
        if let cellHeight = cellVM.cellHeight { return cellHeight }
        return cellVM.cellType.getHeightEstimatedCell()
    }
    
    /// Get table view cell for row
    static func tableViewCell(forRowAtIndexPath indexPath: IndexPath, _ tableView: UITableView, cellsVM: [GNBBaseTableViewCellViewModel], delegate: Any) -> UITableViewCell {
        
        let index = indexPath.row
        guard let cellVM = getCellVM(atIndex: index, forCellsVM: cellsVM) else { return UITableViewCell() }
        
        switch cellVM.cellType {
        case .productListItemCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellType.getNibName(), for: indexPath) as? GNBProductListItemTableViewCell {
                cell.configure(cellVM: cellVM)
                return cell
            }
            
        case .productDetailItem:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellType.getNibName(), for: indexPath) as? GNBProductDetailItemTableViewCell {
                cell.configure(cellVM: cellVM)
                return cell
            }
            
        case .loadingCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellType.getNibName(), for: indexPath) as? GNBLoadingTableViewCell {
                cell.configure(cellVM: cellVM)
                return cell
            }
            
        case .errorCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellType.getNibName(), for: indexPath) as? GNBErrorTableViewCell {
                cell.configure(cellVM: cellVM, delegate: delegate as? GNBErrorTableViewCellProtocol)
                return cell
            }
        }

        return UITableViewCell()
    }
    
    /// Get cellVM at index if index is valid.
    static func getCellVM(atIndex index: Int, forCellsVM cellsVM: [GNBBaseTableViewCellViewModel]) -> GNBBaseTableViewCellViewModel? {
        guard index >= 0 && index < cellsVM.count else { return nil }
        return cellsVM[index]
    }
    
}
