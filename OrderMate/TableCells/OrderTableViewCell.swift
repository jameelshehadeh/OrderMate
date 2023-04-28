//
//  OrderTableViewCell.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 26/04/2023.
//

import UIKit
import AVFoundation

protocol OrderTableViewCellDelegate : AnyObject {
    
    func updateCellStatus(indexPath: IndexPath)
    
}

class OrderTableViewCell: UITableViewCell {

    var timer: Timer?
    var audioPlayer: AVAudioPlayer?

    weak var delegate : OrderTableViewCellDelegate?
    var indexPath : IndexPath?
    
    private lazy var contentVStack : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [hStackView,orderNoLabel,progressBarView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
        return stackView
    }()
    
    private lazy var hStackView : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [orderNameLabel,orderStatusButton])
        stackView.axis = .horizontal
        stackView.spacing = 20
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
    
    private lazy var orderStatusButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .medium)
        button.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        button.addTarget(self, action: #selector(didTapStatus), for: .touchUpInside)
        button.setTitle("New", for: .normal)
        return button
    }()
    
    private lazy var progressBarView : UIView = {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
    }()
    
    private lazy var progressBar : UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progressTintColor = .purple
        progressBar.isHidden = true
        progressBar.progress = 0.0
        return progressBar
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        updateUI()
    }
    
    func updateUI(){
        self.selectionStyle = .none
        contentView.addSubview(contentVStack)
        contentVStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func configureCell(with model: Order) {
        orderNoLabel.text = "Order no: \(model.orderNo)"
        orderNameLabel.text = "Order name: \(model.name)"
        orderStatusButton.setTitle(model.status.rawValue, for: .normal)
        model.status == .delivered ? (orderStatusButton.backgroundColor = .systemGreen) : (orderStatusButton.backgroundColor = .purple)
    }
    
  func playDeliveredSound() {
      
      guard let url = Bundle.main.url(forResource: "BellSound", withExtension: "mp3") else { return }
        
      
      DispatchQueue.global(qos: .userInitiated).async { [weak self] in
          guard let self else {return}
          do {
              self.audioPlayer = try AVAudioPlayer(contentsOf: url)
              self.audioPlayer?.prepareToPlay()
          } catch {
              print("Error loading sound file: \(error.localizedDescription)")
          }
          
          guard let player = audioPlayer else { return }
          
          if !player.isPlaying {
              player.play()
          }
      }
  }
    
    func startProgress() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    @objc func updateProgress() {
        if progressBar.progress < 1.0 {
            progressBar.isHidden = false
            progressBar.progress += 1.0/150.0
        }
        else {
            stopProgress()
        }
    }

    
    func stopProgress() {
        playDeliveredSound()
        timer?.invalidate()
        timer = nil
    }
    
    @objc func didTapStatus(){
        guard let indexPath else {return}
        delegate?.updateCellStatus(indexPath: indexPath)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


