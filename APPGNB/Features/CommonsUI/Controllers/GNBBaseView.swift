//
//  GNBBaseView.swift
//  APPGNB
//
//  Created by Jordi Durán on 05/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBBaseView: UIView {

    // MARK: - Constants, vars

    open fileprivate (set) var viewNibName: String?
    fileprivate let bundle = APPGNB.bundle

    
    // Live Cycle Method's
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupXib() {
        let view = loadViewFromNib()
        view.frame = self.bounds
        
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                 UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        guard let nibName = viewNibName else { return UIView() }
        if let customView = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
            return customView
        }
        return UIView()
    }
    
}
