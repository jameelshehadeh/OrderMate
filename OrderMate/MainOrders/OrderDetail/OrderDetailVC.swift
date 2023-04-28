//
//  OrderDetailVC.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 28/04/2023.
//

import UIKit

class OrderDetailVC: UIViewController {

    var order : Order
    
    private lazy var contentVStack : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [hStackView,orderNoLabel,createdTimeLabel,UIView()])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .white
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
        return stackView
    }()
    
    private lazy var hStackView : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [orderNameLabel,UIView(),orderStatusLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    
    private lazy var orderNameLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    private lazy var orderNoLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    private lazy var orderStatusLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var createdTimeLabel : UILabel = {
        let label = UILabel()
        return label
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(model: Order) {
        self.order = model
        super.init(nibName: nil, bundle: nil)
        configureUI(model: model)
    }
        
    func configureUI(model: Order) {
        
        orderNoLabel.text = "No: \(model.orderNo)"
        orderNameLabel.text = "Name: \(model.name)"
        orderStatusLabel.text = "Status: \(model.status.rawValue)"
        createdTimeLabel.text = "Created time: \(Util.formatDate(timeStamp: model.createdTime))"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(contentVStack)
        
        contentVStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}
