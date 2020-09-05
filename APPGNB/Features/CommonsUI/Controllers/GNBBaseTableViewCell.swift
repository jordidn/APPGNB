//
//  GNBBaseTableViewCell.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

protocol GNBBaseTableViewCellDelegate: class {
    func configure(cellVM: GNBBaseTableViewCellViewModel)
    func configureAccesibility()
}

class GNBBaseTableViewCell: UITableViewCell, GNBBaseTableViewCellDelegate {

    // MARK: - var, constants, etc...
    
    fileprivate (set) var baseCellVM: GNBBaseTableViewCellViewModel?
    
    
    // MARK: - Live cicle method's
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.configureAccesibility()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - Override for custom implementation
    
    open func configure(cellVM: GNBBaseTableViewCellViewModel) { self.baseCellVM = cellVM }
    open func configureAccesibility() {}

}
