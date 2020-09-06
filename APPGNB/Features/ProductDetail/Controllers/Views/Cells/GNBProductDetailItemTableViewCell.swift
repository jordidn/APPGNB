//
//  GNBProductDetailItemTableViewCell.swift
//  APPGNB
//
//  Created by Jordi Durán on 06/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBProductDetailItemTableViewCell: GNBBaseTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    
    // MARK: - Config Methods
    
    override func configure(cellVM: GNBBaseTableViewCellViewModel) {
        super.configure(cellVM: cellVM)
        guard let cellVM = cellVM as? GNBProductDetailItemCellViewModel else { return }
        
        self.lblTitle.text = cellVM.titleText
        self.lblSubtitle.text = cellVM.subtitleText
        self.lblAmount.text = cellVM.amountText
        
        self.separatorView.isHidden = !cellVM.showSeparator
    }
    
}



// MARK: - Cell View Model

class GNBProductDetailItemCellViewModel: GNBBaseTableViewCellViewModel {
    
    var subtitleText: String?
    var amountText: String?
    
    init(titleText: String?, subtitleText: String?, amountText: String?, showSeparator: Bool = true, cellActionIdentifier: Any? = nil) {
        super.init(cellType: .productDetailItem)
        self.titleText = titleText
        self.showSeparator = showSeparator
        self.cellActionIdentifier = cellActionIdentifier
        
        self.subtitleText = subtitleText
        self.amountText = amountText
    }
    
}
