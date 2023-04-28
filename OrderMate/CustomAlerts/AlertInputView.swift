//
//  CustomAlert.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 28/04/2023.
//

import UIKit

class AlertInputView: UIView {
    
    static let shared: AlertInputView = AlertInputView()
    
    var confirmAction: ((String?)->())?
    
    static func show(onWindowOf view: UIView, alertTitle: String, placeholder: String, confirmTitle: String) {
        guard let window = view.window else { return }
        window.addSubview(AlertInputView.shared)
        AlertInputView.shared.confirmButton.titleLabel.text = confirmTitle
        self.shared.titleLabel.text = alertTitle
        self.shared.inputTextField.placeholder = placeholder

        self.shared.confirmGesture.addTarget(self.shared, action: #selector(didTapConfirm))
        
        self.shared.cancelGesture.addTarget(self.shared, action: #selector(didTapCancel))
        
        AlertInputView.shared.frame = window.bounds
    }
    
    let confirmGesture = UITapGestureRecognizer()
    let cancelGesture = UITapGestureRecognizer()

    
    private lazy var containerVStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        return stackView
    }()
    
    private lazy var actionButtonsHStack: UIStackView = {
        let v = UIStackView.init(arrangedSubviews: [cancelButton, confirmButton])
        v.axis = .horizontal
        v.spacing = 20
        v.snp.makeConstraints { make in
            make.height.equalTo(35)
        }
        v.distribution = .fillEqually
        return v
    }()
    
    private lazy var cancelButton: OptionButtonView = {
        let v = OptionButtonView(title: "cancel", titleColor: .purple, corners: 16, viewBackground : .white)
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.purple.cgColor
        v.layer.cornerRadius = 12
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(cancelGesture)
        return v
    }()
    
    private lazy var confirmButton: OptionButtonView = {
        let v = OptionButtonView(title: "confirm", titleColor: .white, corners: 16, viewBackground : .purple)
        v.layer.cornerRadius = 12
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(confirmGesture)
        return v
    }()
    
    private let titleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .purple
        v.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        v.textAlignment = .natural
        v.numberOfLines = 0
        return v
    }()
    
    private let inputTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        textField.adjustsFontSizeToFitWidth = true
        textField.backgroundColor = .systemBackground
        textField.minimumFontSize = 8
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    func initViews(){
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        
        containerVStack.layer.cornerRadius = 15
        containerVStack.backgroundColor = .white
        containerVStack.addArrangedSubview(titleLabel)
        containerVStack.addArrangedSubview(inputTextField)
        containerVStack.addArrangedSubview(actionButtonsHStack)
            
        self.addSubview(containerVStack)
        containerVStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(50)
        }
    
    }
    
    @objc func didTapConfirm(){
        guard let confirmAction , let text = AlertInputView.shared.inputTextField.text , !text.isEmpty else {return}
        confirmAction(text)
        AlertInputView.shared.inputTextField.text = ""
        AlertInputView.shared.removeFromSuperview()
    }
    
    @objc func didTapCancel(){
        AlertInputView.shared.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


fileprivate class OptionButtonView: UIView {

    private var viewBackgroundColor: UIColor?
    private var roundedCourners: CGFloat = 12
    
    private lazy var optionBackgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = self.viewBackgroundColor
        v.layer.cornerRadius = roundedCourners
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        return label
    }()
        
    required init(title: String?, titleColor: UIColor?, corners: CGFloat, viewBackground: UIColor?) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.viewBackgroundColor = viewBackground
        self.titleLabel.textColor = titleColor ?? .black
        self.roundedCourners = corners
        self.initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initViews() {
        optionBackgroundView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.addSubview(optionBackgroundView)
        optionBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
