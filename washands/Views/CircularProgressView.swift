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
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addCircularShapeLayer()
        addLabel()
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
                                        radius: bounds.height / 2.25,
                                        startAngle: 0,
                                        endAngle: 2 * CGFloat.pi,
                                        clockwise: true)
        circularPath.apply(CGAffineTransform(translationX: bounds.width / 2, y: bounds.height / 2))
        
        let trackLayer = CAShapeLayer()
        trackLayer.frame = frame
        trackLayer.bounds = bounds
        trackLayer.position = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.red.withAlphaComponent(0.25).cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        
        layer.addSublayer(trackLayer)
        
        shapeLayer.frame = frame
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.transform = CATransform3DMakeRotation(-(CGFloat.pi/2), 0, 0, 1)
        
        layer.addSublayer(shapeLayer)
    }
    
    private func addLabel() {
        addSubview(label)
        label.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }

}
