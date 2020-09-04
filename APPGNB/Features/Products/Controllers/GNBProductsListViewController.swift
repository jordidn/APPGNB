//
//  GNBProductsListViewController.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBProductsListViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func buttonPressed(_ sender: Any) {
        guard let viewController = GNBProductDetailViewController.storyboardInstance() else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    // MARK: - Live cicle method's
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    // TODO: - Pasar al Base
    func configureUI() {
        self.title = "Products List"
    }

}
