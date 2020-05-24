//
//  ViewController.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 24/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    let shapeLayer = CAShapeLayer()
//
//    let percentageLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Start"
//        label.textAlignment = .center
//        label.font = .boldSystemFont(ofSize: 32.0)
//        return label
//    }()
    
    private let progress: CircularProgressView = {
        let progress = CircularProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        view.addSubview(percentageLabel)
//        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        percentageLabel.center = view.center
//        
//        let circularPath = UIBezierPath(arcCenter: .zero,
//                                        radius: 100,
//                                        startAngle: 0,
//                                        endAngle: 2 * CGFloat.pi,
//                                        clockwise: true)
//        
//        let trackLayer = CAShapeLayer()
//        trackLayer.path = circularPath.cgPath
//        trackLayer.strokeColor = UIColor.red.withAlphaComponent(0.25).cgColor
//        trackLayer.lineWidth = 10
//        trackLayer.fillColor = UIColor.clear.cgColor
//        trackLayer.lineCap = .round
//        trackLayer.position = view.center
//        
//        view.layer.addSublayer(trackLayer)
//        
//        shapeLayer.path = circularPath.cgPath
//        shapeLayer.strokeEnd = 0
//        shapeLayer.strokeColor = UIColor.red.cgColor
//        shapeLayer.lineWidth = 10
//        shapeLayer.lineCap = .round
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.position = view.center
//        shapeLayer.transform = CATransform3DMakeRotation(-(CGFloat.pi/2), 0, 0, 1)
//        
//        view.layer.addSublayer(shapeLayer)
        
        view.addSubview(progress)
        NSLayoutConstraint.activate([
            progress.topAnchor.constraint(equalTo: view.topAnchor, constant: 256.0),
            progress.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//            progress.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap() {
        progress.startAnimating()
    }


}

