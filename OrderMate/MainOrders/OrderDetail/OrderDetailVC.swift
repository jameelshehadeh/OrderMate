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
        let stackView = UIStackView.init(arrangedSubviews: [orderNameHStack,orderNoHStack,createdTimeHStack,UIView()])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .systemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
        return stackView
    }()
    
    private lazy var orderNameHStack : UIStackView = {
        let foodImage = UIImageView()
        foodImage.contentMode = .scaleAspectFit
        foodImage.image = UIImage(systemName: "fork.knife.circle.fill")
        let stackView = UIStackView.init(arrangedSubviews: [foodImage,orderNameLabel,UIView(),orderStatusLabel])
        stackView.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var createdTimeHStack : UIStackView = {
        let clockImage = UIImageView()
        clockImage.contentMode = .scaleAspectFit
        clockImage.image = UIImage(systemName: "clock.fill")
        let stackView = UIStackView.init(arrangedSubviews: [clockImage,createdTimeLabel,UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    
    private lazy var orderNoHStack : UIStackView = {
        let hashtagImage = UIImageView()
        hashtagImage.contentMode = .scaleAspectFit
        hashtagImage.image = UIImage(systemName: "number.circle.fill")
        let stackView = UIStackView.init(arrangedSubviews: [hashtagImage,orderNoLabel,UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var orderNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17,weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    
    private lazy var orderNoLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17,weight: .bold)
        return label
    }()
    
    private lazy var orderStatusLabel : UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13,weight: .medium)
        label.layer.cornerRadius = 8
        label.adjustsFontSizeToFitWidth = true
        label.snp.makeConstraints { make in
            make.width.equalTo(130)
        }
        label.clipsToBounds = true
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
        title = "Order details"
        orderNoLabel.text = "No: \(model.orderNo)"
        orderNameLabel.text = "Name: \(model.name)"
        orderStatusLabel.text = "Status: \(model.status.rawValue)"
        createdTimeLabel.text = "Created at: \(Util.formatDate(timeStamp: model.createdTime))"
        model.status == .delivered ? (orderStatusLabel.backgroundColor = .systemGreen) : (orderStatusLabel.backgroundColor = .purple)
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
