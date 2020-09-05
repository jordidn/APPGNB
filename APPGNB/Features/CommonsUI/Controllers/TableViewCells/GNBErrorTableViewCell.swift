//
//  GNBErrorTableViewCell.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

protocol GNBErrorTableViewCellProtocol: class {
    func errorButtonPressed(cellActionIdentifier: Any?)
}

class GNBErrorTableViewCell: GNBBaseTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    
    
    // MARK: - Properties
    
    weak var delegate: GNBErrorTableViewCellProtocol?
    
    
    // MARK: - IBActions
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.errorButtonPressed(cellActionIdentifier: baseCellVM?.cellActionIdentifier)
    }
    
    
    // MARK: - Config Methods
    
    func configure(cellVM: GNBBaseTableViewCellViewModel, delegate: GNBErrorTableViewCellProtocol?) {
        super.configure(cellVM: cellVM)
        guard let cellVM = cellVM as? GNBErrorCellViewModel else { return }
        
        self.lblTitle.text = cellVM.titleText
        self.bottomButton.setTitle(cellVM.buttonText, for: .normal)
        
        self.delegate = delegate
    }
    
}


// MARK: - Cell View Model

class GNBErrorCellViewModel: GNBBaseTableViewCellViewModel {
    
    var buttonText: String?
    
    init(titleText: String?, buttonText: String?, cellActionIdentifier: Any? = nil) {
        super.init(cellType: .errorCell)
        self.titleText = titleText
        self.cellActionIdentifier = cellActionIdentifier
        
        self.buttonText = buttonText
    }
    
}
