//
//  GNBProductsListViewController.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBProductsListViewController: GNBBaseViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    fileprivate let viewModel = GNBProductsListViewModel()
    fileprivate var cellsVM = [GNBBaseTableViewCellViewModel]()
    
    
    // MARK: - Live cicle method's
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure and register tableView cells
        registerTableViewCells()
        GNBBaseTableViewCellViewModel.configureTable(tableView, bounces: true)
        
        // Recover cells
        self.cellsVM = viewModel.getCellsVM()
        
        // Fetch data
        fetchData()
            
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func configureUI() {
        self.title = "Products List"
    }
    
    override func fetchData() {
        self.reloadTableView()
        viewModel.fetchProductsList(success: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.reloadTableView()
            
        }, error: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.reloadTableView(withError: true)
        })
    }
    
    
    // MARK: - Config Methods
    
    func registerTableViewCells() {
        tableView.gnbRegisterCell(nibName: .productListItemCell)
        tableView.gnbRegisterCell(nibName: .loadingCell)
        tableView.gnbRegisterCell(nibName: .errorCell)
    }
    
    func reloadTableView(withError error: Bool = false) {
        self.cellsVM = self.viewModel.getCellsVM(withError: error)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

}


// MARK: - TableView extension

extension GNBProductsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return GNBBaseTableViewCellViewModel.tableViewCell(forRowAtIndexPath: indexPath, tableView, cellsVM: cellsVM, delegate: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GNBBaseTableViewCellViewModel.getCellHeight(cellsVM: cellsVM, index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellVM = GNBBaseTableViewCellViewModel.getCellVM(atIndex: indexPath.row, forCellsVM: cellsVM) else { return }
        switch cellVM.cellType {
        case .productListItemCell:
            guard let transactionsList = cellVM.cellActionIdentifier as? [GNBProductItem] else { return }
            guard let viewController = GNBProductDetailViewController.storyboardInstance(transactionsList: transactionsList) else { return }
            self.navigationController?.pushViewController(viewController, animated: true)
            
        default:
            break
        }
    }

}



extension GNBProductsListViewController: GNBErrorTableViewCellProtocol {
    
    func errorButtonPressed(cellActionIdentifier: Any?) {
        viewModel.resetData()
        fetchData()
    }
    
}
