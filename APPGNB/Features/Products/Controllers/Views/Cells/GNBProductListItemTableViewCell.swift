//
//  GNBProductListItemTableViewCell.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBProductListItemTableViewCell: GNBBaseTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    
    // MARK: - Config Methods
    
    override func configure(cellVM: GNBBaseTableViewCellViewModel) {
        super.configure(cellVM: cellVM)
        guard let cellVM = cellVM as? GNBProductListItemCellViewModel else { return }
        
        self.lblTitle.text = cellVM.titleText
        self.lblSubtitle.text = cellVM.subtitleText
        self.separatorView.isHidden = !cellVM.showSeparator
        
        self.accessoryType = .disclosureIndicator
    }
    
}



// MARK: - Cell View Model

class GNBProductListItemCellViewModel: GNBBaseTableViewCellViewModel {
    
    var subtitleText: String?
    
    init(titleText: String?, subtitleText: String?, showSeparator: Bool = true, cellActionIdentifier: Any? = nil) {
        super.init(cellType: .productListItemCell)
        self.titleText = titleText
        self.showSeparator = showSeparator
        self.cellActionIdentifier = cellActionIdentifier
        
        self.subtitleText = subtitleText
    }
    
}
