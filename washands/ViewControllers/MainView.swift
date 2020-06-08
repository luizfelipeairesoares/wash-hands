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
    
    private let labelStep: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.font = .boldSystemFont(ofSize: Constants.fontSize)
        label.textColor = .black
        label.numberOfLines = 4
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progress: CircularProgressView = {
        let progress = CircularProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    // MARK: - Public Properties
    
    weak var delegate: MainViewDelegate?
    
    // MARK: - Init
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = AppColors.viewBg.color
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
            self.labelStep.alpha = 1
        }) { (completed) in
            self.player.play()
            self.progress.startAnimating(duration: 30) { [weak self] (elapsedTime) in
                switch elapsedTime {
                case 28...30:
                    let localizedString = AppLocalizedStrings.circularProgressView.string(key: "label_step1")
                    self?.labelStep.text = "Step 1:\n" + localizedString
                case 25...27:
                    let localizedString = AppLocalizedStrings.circularProgressView.string(key: "label_step2")
                    self?.labelStep.text = "Step 2:\n" + localizedString
                case 22...24:
                    let localizedString = AppLocalizedStrings.circularProgressView.string(key: "label_step3")
                    self?.labelStep.text = "Step 3:\n" + localizedString
                case 18...21:
                    let localizedString = AppLocalizedStrings.circularProgressView.string(key: "label_step4")
                    self?.labelStep.text = "Step 4:\n" + localizedString
                case 16...18:
                    let localizedString = AppLocalizedStrings.circularProgressView.string(key: "label_step5")
                    self?.labelStep.text = "Step 5:\n" + localizedString
                case 13...15:
                    let localizedString = AppLocalizedStrings.circularProgressView.string(key: "label_step6")
                    self?.labelStep.text = "Step 6:\n" + localizedString
                case 10...12:
                    let localizedString = AppLocalizedStrings.circularProgressView.string(key: "label_step7")
                    self?.labelStep.text = "Step 7:\n" + localizedString
                case 7...9:
                    let localizedString = AppLocalizedStrings.circularProgressView.string(key: "label_step8")
                    self?.labelStep.text = "Step 8:\n" + localizedString
                case 5...6:
                    let localizedString = AppLocalizedStrings.circularProgressView.string(key: "label_step9")
                    self?.labelStep.text = "Step 9:\n" + localizedString
                case 2...4:
                    let localizedString = AppLocalizedStrings.circularProgressView.string(key: "label_step10")
                    self?.labelStep.text = "Step 10:\n" + localizedString
                case 0...2:
                    let localizedString = AppLocalizedStrings.circularProgressView.string(key: "label_step11")
                    self?.labelStep.text = "Final Step:\n" + localizedString
                default:
                    self?.labelStep.text = ""
                }
            }
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
        
        addSubview(labelStep)
        setupLabelStepConstraints()
        
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
    
    private func setupLabelStepConstraints() {
        NSLayoutConstraint.activate([
            labelStep.topAnchor.constraint(equalTo: labelCredits.bottomAnchor, constant: (Constants.edge * 2)),
            labelStep.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (Constants.edge * 2)),
            labelStep.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Constants.edge * 2)),
            labelStep.bottomAnchor.constraint(equalTo: progress.topAnchor, constant: -(Constants.edge * 2))
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
            self?.labelStep.alpha = 0
        }) { (completed) in
            self.player.pause()
        }
    }
    
    @objc private func handleTap() {
        self.delegate?.didTapStart()
    }

}
