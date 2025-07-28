//
//  CircularProgressBarView.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/22/25.
//

import UIKit

final class CircularProgressBarView: UIView {
    
    // MARK: - Constraints
    
    private struct Appearance {
        static let lineWidth: CGFloat = 10.0
        static let backgroundColor = UIColor.background
        static let progressColor = UIColor.systemBlue
    }
    
    // MARK: - Layers
    
    private lazy var purpleProgressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = Appearance.lineWidth
        layer.lineCap = .round
        layer.strokeStart = 0
        layer.strokeEnd = 0
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.main.cgColor
        
        return layer
    }()
    
    private lazy var blandProgressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = Appearance.lineWidth
        layer.lineCap = .round
        layer.strokeStart = 0
        layer.strokeEnd = 0
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.circleSection.cgColor
        
        return layer
    }()
    
    private lazy var yellowProgressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = Appearance.lineWidth
        layer.lineCap = .round
        layer.strokeStart = 0
        layer.strokeEnd = 0
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.brightGreen.cgColor
        
        return layer
    }()
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = Appearance.lineWidth
        layer.lineCap = .round
        layer.strokeStart = 0
        layer.strokeEnd = 1
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = Appearance.backgroundColor.cgColor
        
        return layer
    }()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        loadLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Layout
    
    func loadLayout() {
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(purpleProgressLayer)
        layer.addSublayer(blandProgressLayer)
        layer.addSublayer(yellowProgressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: (bounds.width - Appearance.lineWidth) / 2,
            startAngle: -CGFloat.pi / 2,
            endAngle: CGFloat.pi * 3 / 2,
            clockwise: true
        ).cgPath
        
        backgroundLayer.path = circlePath
        purpleProgressLayer.path = circlePath
        blandProgressLayer.path = circlePath
        yellowProgressLayer.path = circlePath
    }
    
    // MARK: - Public
    
    func setProgress(progress1: CGFloat, progress2: CGFloat, animated: Bool) {
        // Ensure progress is between 0 and 1
        let yellowClampedProgress = max(min(progress1, 1), 0)
        let purpleClempledProgress = max(min(progress2, 1), 0) + yellowClampedProgress
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = purpleProgressLayer.strokeEnd
            animation.toValue = yellowClampedProgress
            animation.duration = 0.5
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
            purpleProgressLayer.removeAnimation(forKey: "progress")
            purpleProgressLayer.add(animation, forKey: "progress")
        }
        
        purpleProgressLayer.strokeEnd = yellowClampedProgress
        blandProgressLayer.strokeStart = purpleProgressLayer.strokeEnd + 0.03
        blandProgressLayer.strokeEnd = purpleClempledProgress
        yellowProgressLayer.strokeStart = blandProgressLayer.strokeEnd + 0.03
        yellowProgressLayer.strokeEnd = 0.96
    }
}





// MARK: - Example Usage

//final class CircleVC: UIViewController {
//
//    private lazy var circularProgressBarView = CircularProgressBarView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(circularProgressBarView)
//
//        circularProgressBarView.setProgress(progress1: 0.1, progress2: 0.1, animated: true)
//
//        circularProgressBarView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.size.equalTo(250)
//        }
//    }
//}
