//
//  GNBLoadingTableViewCell.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBLoadingTableViewCell: GNBBaseTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Config Methods
    
    override func configure(cellVM: GNBBaseTableViewCellViewModel) {
        super.configure(cellVM: cellVM)
        
        activityIndicator.startAnimating()
    }
    
}


// MARK: - Cell View Model

class GNBLoadingCellViewModel: GNBBaseTableViewCellViewModel {
    
    init() {
        super.init(cellType: .loadingCell)
    }
    
}
