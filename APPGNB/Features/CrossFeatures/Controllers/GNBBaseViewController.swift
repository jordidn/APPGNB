//
//  GNBBaseViewController.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

}



extension GNBBaseViewController: GNBCommonViewControllerProtocol {
    func configureUI() {}
    func fetchData() {}
}



@objc public protocol GNBCommonViewControllerProtocol {
    
    // MARK: - Needed methods
    
    ///This protocol method must be called when a view controller needs to prepare basic UI configurations.
    func configureUI()
    
    
    // MARK: - Optional methods
    
    ///This protocol method must be called and implemented when a @objc @objc @objc view controller needs to fetch data from ViewModel.
    func fetchData()
}

