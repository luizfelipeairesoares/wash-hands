//
//  MainView.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 29/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit
import AVKit

protocol MainViewDelegate: AnyObject {
    
    func didTapStart()
    
}

class MainView: UIView {
    
    // MARK: - Private Properties
    
    private enum Constants {
        static let edge: CGFloat = 8.0
        static let fontSize: CGFloat = 16.0
        static let customViewWidth: CGFloat = 256.0
        static let customViewHeight: CGFloat = 256.0
    }

    private let player: CustomPlayer = {
        let player = CustomPlayer()
        player.view.alpha = 0
        return player
    }()
    
    private let labelCredits: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.font = .boldSystemFont(ofSize: Constants.fontSize)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progress: CircularProgressView = {
        let progress = CircularProgressView(with: UIColor(hex: "006994"))
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    // MARK: - Public Properties
    
    weak var delegate: MainViewDelegate?
    
    // MARK: - Init
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(hex: "f7fbfd")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Functions
    
    public func setupAssetInPlayer(asset: AVAsset, username: String) {
        player.set(asset)
        labelCredits.text = "Credits: \(username)"
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
            self.player.view.alpha = 1
            self.labelCredits.alpha = 1
        }) { (completed) in
            self.player.play()
            self.progress.startAnimating(duration: 10)
        }
    }
    
    // MARK: - Private Functions
    
    private func setupView() {
        progress.didFinish = { [weak self] in
            self?.progressFinished()
        }
        
        addSubview(player.view)
        setupPlayerConstraints()
        
        addSubview(labelCredits)
        setupLabelCreditsConstraints()
        
        addSubview(progress)
        setupProgressConstraints()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    private func setupPlayerConstraints() {
        NSLayoutConstraint.activate([
            player.view.topAnchor.constraint(equalTo: topAnchor, constant: (Constants.edge * 8)),
            player.view.centerXAnchor.constraint(equalTo: centerXAnchor),
            player.view.widthAnchor.constraint(equalToConstant: Constants.customViewWidth),
            player.view.heightAnchor.constraint(equalToConstant: Constants.customViewHeight)
        ])
    }
    
    private func setupLabelCreditsConstraints() {
        NSLayoutConstraint.activate([
            labelCredits.topAnchor.constraint(equalTo: player.view.bottomAnchor, constant: (Constants.edge * 2)),
            labelCredits.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelCredits.heightAnchor.constraint(equalToConstant: (Constants.edge * 3))
        ])
    }
    
    private func setupProgressConstraints() {
        NSLayoutConstraint.activate([
            progress.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(Constants.edge * 8)),
            progress.centerXAnchor.constraint(equalTo: centerXAnchor),
            progress.widthAnchor.constraint(equalToConstant: Constants.customViewWidth),
            progress.heightAnchor.constraint(equalToConstant: Constants.customViewHeight)
        ])
    }
    
    private func progressFinished() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: { [weak self] in
            self?.player.view.alpha = 0
            self?.labelCredits.alpha = 0
        }) { (completed) in
            self.player.pause()
        }
    }
    
    @objc private func handleTap() {
        self.delegate?.didTapStart()
    }

}
