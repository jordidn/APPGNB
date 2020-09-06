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
    
    public static func storyboardInstance(transactionsList: [GNBProductItem]) -> GNBProductDetailViewController? {
        guard let viewController = self.gnbStoryboardInstance(storyboardIdentifier: "GMBProductDetailStoryboard") as? GNBProductDetailViewController else { return nil }
        
        viewController.viewModel.setTransactionsList(transactionsList: transactionsList)
        return viewController
    }
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var summaryContainerView: GNBSummaryView!
    
    
    // MARK: - Properties
    
    fileprivate let viewModel = GNBProductDetailViewModel()
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
        self.title = "Transactions for \(viewModel.getProductName())"
    }
    
    override func fetchData() {
        self.reloadTableView()
        viewModel.fetchRates(success: { [weak self] in
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
        self.configureSummaryView(withError: error)
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func configureSummaryView(withError error: Bool = false) {
        self.summaryContainerView.isHidden = error || !viewModel.hasToShowTotalAmount()
        self.summaryContainerView.configure(titleText: "Total Amount:",
                                            amountText: viewModel.getTotalAmountFormatted())
    }

}



// MARK: - TableView extension

extension GNBProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return GNBBaseTableViewCellViewModel.tableViewCell(forRowAtIndexPath: indexPath, tableView, cellsVM: cellsVM, delegate: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GNBBaseTableViewCellViewModel.getCellHeight(cellsVM: cellsVM, index: indexPath.row)
    }

}



extension GNBProductDetailViewController: GNBErrorTableViewCellProtocol {
    
    func errorButtonPressed(cellActionIdentifier: Any?) {
        viewModel.resetData()
        fetchData()
    }
    
}
