//
//  CircularProgressView.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 24/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

class CircularProgressView: UIView {
    
    // MARK: - Private properties
    
    private enum Constants {
        static let labelFontSize: CGFloat = 32.0
    }

    private let color: UIColor!
    private let shapeLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    
    private var timer: Timer?
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: Constants.labelFontSize)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icon_hands")
        imgView.contentMode = .scaleAspectFit
        imgView.alpha = 0.0
        return imgView
    }()
    
    // MARK: - Public Properties
    
    var didFinish: (() -> Void)?
    
    // MARK: - Init
    
    required init(with color: UIColor = UIColor(hex: "0E54A3")) {
        self.color = color
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addCircularShapeLayer()
        addLabel()
        addImageView()
    }
    
    // MARK: - Public Functions
    
    public func startAnimating(duration: TimeInterval, progress: ((TimeInterval) -> Void)?) {
        if timer == nil {
            shapeLayer.strokeColor = color.cgColor
            
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.toValue = 1
            basicAnimation.duration = duration
            basicAnimation.fillMode = .forwards
            basicAnimation.isRemovedOnCompletion = true
            
            var elapsedTime = duration
            label.text = "\(Int(elapsedTime))"
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (tmr) in
                DispatchQueue.main.async { [weak self] in
                    progress?(elapsedTime)
                    if elapsedTime > 0 {
                        elapsedTime -= 1
                        self?.label.text = "\(Int(elapsedTime))"
                    } else {
                        tmr.invalidate()
                        self?.label.text = "Start"
                        self?.timer = nil
                        self?.showTimerEndAnimation()
                    }
                }
            })
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
                self.label.frame.origin.y += 40.0
                self.imageView.alpha = 1.0
            }) { (completed) in
                self.shapeLayer.add(basicAnimation, forKey: "forward")
            }
        }
    }
    
    // MARK: - Private functions
    
    private func addCircularShapeLayer() {
        let circularPath = UIBezierPath(arcCenter: .zero,
                                        radius: bounds.height / 2.25,
                                        startAngle: 0,
                                        endAngle: 2 * CGFloat.pi,
                                        clockwise: true)
        circularPath.apply(CGAffineTransform(translationX: bounds.width / 2, y: bounds.height / 2))
        
        trackLayer.frame = frame
        trackLayer.bounds = bounds
        trackLayer.position = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeEnd = 1
        trackLayer.strokeColor = color.withAlphaComponent(0.5).cgColor
        trackLayer.lineWidth = 10
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(trackLayer)
        
        shapeLayer.frame = frame
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = color.cgColor
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
    
    private func addImageView() {
        addSubview(imageView)
        imageView.frame = CGRect(x: (bounds.midX - 32.0), y: (bounds.midY - 56.0), width: 64.0, height: 64.0)
    }
    
    private func showBackwardsAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.shapeLayer.strokeColor = self.color.withAlphaComponent(0.25).cgColor
            let basicAnimation = CABasicAnimation(keyPath: "strokeBegin")
            basicAnimation.toValue = 0
            basicAnimation.duration = 5
            basicAnimation.fillMode = .forwards
            basicAnimation.isRemovedOnCompletion = true
            self.shapeLayer.add(basicAnimation, forKey: "backward")
        }
    }
    
    private func showTimerEndAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveLinear, animations: {
            self.imageView.alpha = 0.0
            self.label.frame.origin.y -= 40.0
        }, completion: { [weak self] (completed) in
            self?.didFinish?()
        })
    }

}
