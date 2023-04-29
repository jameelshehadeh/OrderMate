//
//  ViewController.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 26/04/2023.
//

import UIKit
import SnapKit

class MainOrdersListVC: UIViewController , Alertable {

    let viewModel : MainOrderListViewModel
    
    private lazy var searchController : UISearchController = {
        let sc = UISearchController()
        sc.searchBar.backgroundColor = .systemBackground
        sc.searchBar.placeholder = "Search order by ID or name"
        sc.searchResultsUpdater = self
        return sc
    }()
    
    private lazy var tableView : UITableView = {
       let tableView = UITableView()
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: Constants.orderCellId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var floatingButton : UIButton = {
       let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .medium)
        button.setTitle("Place order", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapPlaceOrder), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindData()
    }
    
    init(viewModel: MainOrderListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(){
        
        viewModel.didUpdateOrders = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.showAlert = { [weak self] alertMessage in
            guard let self else {return}
            showAlert(title: "Warning", message: alertMessage, preferredStyle: .alert, completion: nil)
        }
        
    }
    
    func configureUI(){
        
        title = "Orders List"
        view.backgroundColor = .systemBackground
        setNavBarAppearance()
        navigationItem.searchController = searchController
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(floatingButton)
        floatingButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(170)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalTo(view.snp_trailingMargin)
        }
        
    }
    
    @objc func didTapPlaceOrder(){
                
        AlertInputView.shared.show(onWindowOf: view, alertTitle: "Enter Order name", placeholder: "Enter order name", confirmTitle: "Place order")

        AlertInputView.shared.confirmAction = { [weak self] orderName in
            guard let self , let orderName , !orderName.isEmpty else {return}
            self.viewModel.addOrder(orderName: orderName)
            
        }
    }
}


extension MainOrdersListVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfOrders
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderItem = viewModel.order(at: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.orderCellId, for: indexPath) as? OrderTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: orderItem)
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.order(at: indexPath.row)
        let vc = OrderDetailVC(model: model)
        push(vc)
    }
}


extension MainOrdersListVC : OrderTableViewCellDelegate {
    
    func updateCellStatus(indexPath: IndexPath) {
        viewModel.updateOrderStatus(at: indexPath.row)
    }
    
}


extension MainOrdersListVC : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {return}
        viewModel.searchOrders(text: searchText.lowercased())
    }
    
}

