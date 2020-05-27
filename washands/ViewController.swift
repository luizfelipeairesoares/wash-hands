//
//  ViewController.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 24/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let progress: CircularProgressView = {
        let progress = CircularProgressView(with: UIColor(hex: "006994"))
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(progress)
        NSLayoutConstraint.activate([
            progress.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progress.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progress.widthAnchor.constraint(equalToConstant: 256),
            progress.heightAnchor.constraint(equalToConstant: 256)
        ])
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap() {
        progress.startAnimating(duration: 10)
    }

}

