//
//  GNBSummaryView.swift
//  APPGNB
//
//  Created by Jordi Durán on 05/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBSummaryView: GNBBaseView {

    //MARK: - IBOUtlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    
    // MARK: - var, constants, etc...
    
    override var viewNibName: String? { return "GNBSummaryView" }
    
    
    // MARK: - Config Methods
    
    func configure(titleText: String?, amountText: String?) {
        self.lblTitle.text = titleText
        self.lblAmount.text = amountText
    }

}
