//
//  DeliveredOrderListVC.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 26/04/2023.
//

import UIKit

class DeliveredOrdersListVC: UIViewController {

    let viewModel = DeliveredOrdersViewModel()
    
    private lazy var tableView : UITableView = {
       let tableView = UITableView()
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: Constants.orderCellId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        NotificationCenter.default.addObserver(self, selector: #selector(handleOrdersChanged(_:)), name: .init(Constants.archiveOrderNotification), object: nil)
    }
    
    deinit {
           NotificationCenter.default.removeObserver(self, name: Notification.Name(Constants.archiveOrderNotification), object: nil)
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func handleOrdersChanged(_ notification: Notification) {
            tableView.reloadData()
        }

    func configureUI(){
        
        title = "Delivered Orders"
        view.backgroundColor = .systemBackground
        setNavBarAppearance()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    
    }
}


extension DeliveredOrdersListVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfOrders
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderItem = viewModel.orders[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.orderCellId, for: indexPath) as? OrderTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: orderItem)
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.order(at: indexPath.row)
        let vc = OrderDetailVC(model: model)
        push(vc)
    }
}


