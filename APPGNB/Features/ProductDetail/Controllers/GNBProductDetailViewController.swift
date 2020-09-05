//
//  GNBProductDetailViewController.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBProductDetailViewController: GNBBaseViewController {

    // MARK: - Storyboard Instance
    
    public static func storyboardInstance() -> GNBProductDetailViewController? {
        guard let viewController = self.gnbStoryboardInstance(storyboardIdentifier: "GMBProductDetailStoryboard") as? GNBProductDetailViewController else { return nil }
        
        return viewController
    }
    
    
    // MARK: - IBOutlets
    
    
    
    
    
    // MARK: - Live cicle method's
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Product X detail"
    }

}
