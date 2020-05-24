//
//  CircularProgressView.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 24/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

class CircularProgressView: UIView {

    private let shapeLayer = CAShapeLayer()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32.0)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addCircularShapeLayer()
        addLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Public Functions
    
    public func updateLabel(_ text: String) {
        label.text = text
    }
    
    public func startAnimating() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "basic")
    }
    
    // MARK: - Private functions
    
    private func addCircularShapeLayer() {
        let circularPath = UIBezierPath(arcCenter: .zero,
                                        radius: 100,
                                        startAngle: 0,
                                        endAngle: 2 * CGFloat.pi,
                                        clockwise: true)
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.red.withAlphaComponent(0.25).cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        trackLayer.position = center
        
        layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.position = center
        shapeLayer.transform = CATransform3DMakeRotation(-(CGFloat.pi/2), 0, 0, 1)
        
        layer.addSublayer(shapeLayer)
    }
    
    private func addLabel() {
        addSubview(label)
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        label.center = center
    }

}
