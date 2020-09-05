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
        guard let gamesList = manager.productsList else { return [GNBLoadingCellViewModel()] }
        for game in gamesList {
//            guard let internationalName = game.getGameName(), let asset = game.assets?.coverTiny else { continue }
//            cellsVM.append(SRGameListCellViewModel(titleText: internationalName, imagePathURL: URL(string: asset.uri ?? ""), imageWith: asset.width, imageHeight: asset.height, cellActionIdentifier: game))
        }
        
        cellsVM.append(GNBErrorCellViewModel(titleText: "An error has occurred", buttonText: "Try again"))
        return cellsVM
    }

    
    // MARK: - Fetch Request
    
    func fetchProductsList(success succeed: @escaping (() -> Void), error: @escaping (() -> Void)) {
        manager.fetchProductsList(success: succeed, error: error)
    }
    
    
    
}
