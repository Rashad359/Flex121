//
//  WeightVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/9/25.
//

import UIKit

class WeightpickVC: UIViewController {
    
    // MARK: - UI Components
    private let weightLabel = UILabel()
    private let kgLabel = UILabel()
    private let scaleContainerView = UIView()
    private let scaleScrollView = UIScrollView()
    private let scaleContentView = UIView()
    private let centerIndicatorView = UIView()
    
    // MARK: - Properties
    private let minWeight: Float = 20.0
    private let maxWeight: Float = 250.0
    private let defaultWeight: Float = 46.0
    private let scaleSpacing: CGFloat = 20.0
    private let scaleWidth: CGFloat = 2.0
    private let majorScaleHeight: CGFloat = 40.0
    private let minorScaleHeight: CGFloat = 20.0
    
    private var currentWeight: Float = 46.0
    private var scaleViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupScale()
        setupGestureRecognizers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollToWeight(defaultWeight, animated: false)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
        
        setupWeightLabels()
        setupScaleContainer()
        setupCenterIndicator()
        
        setupConstraints()
    }
    
    private func setupWeightLabels() {
        // Weight number label
        weightLabel.text = String(format: "%.1f", currentWeight)
        weightLabel.font = UIFont.systemFont(ofSize: 72, weight: .light)
        weightLabel.textColor = .white
        weightLabel.textAlignment = .center
        weightLabel.numberOfLines = .zero
        
        // kg label
        kgLabel.text = "kg"
        kgLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
        kgLabel.textColor = .white
        kgLabel.textAlignment = .left
        
        view.addSubview(weightLabel)
        view.addSubview(kgLabel)
    }
    
    private func setupScaleContainer() {
        scaleContainerView.backgroundColor = .clear
        scaleScrollView.backgroundColor = .clear
        scaleScrollView.showsHorizontalScrollIndicator = false
        scaleScrollView.delegate = self
        
        view.addSubview(scaleContainerView)
        scaleContainerView.addSubview(scaleScrollView)
        scaleScrollView.addSubview(scaleContentView)
    }
    
    private func setupCenterIndicator() {
        centerIndicatorView.backgroundColor = UIColor(red: 0.6, green: 0.4, blue: 1.0, alpha: 1.0)
        centerIndicatorView.layer.cornerRadius = 1.0
        scaleContainerView.addSubview(centerIndicatorView)
    }
    
    private func setupConstraints() {
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        kgLabel.translatesAutoresizingMaskIntoConstraints = false
        scaleContainerView.translatesAutoresizingMaskIntoConstraints = false
        scaleScrollView.translatesAutoresizingMaskIntoConstraints = false
        scaleContentView.translatesAutoresizingMaskIntoConstraints = false
        centerIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Weight label
            weightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            weightLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            // kg label
            kgLabel.leadingAnchor.constraint(equalTo: weightLabel.trailingAnchor, constant: 8),
            kgLabel.bottomAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: -8),
            
            // Scale container
            scaleContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scaleContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scaleContainerView.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 80),
            scaleContainerView.heightAnchor.constraint(equalToConstant: 80),
            
            // Scale scroll view
            scaleScrollView.leadingAnchor.constraint(equalTo: scaleContainerView.leadingAnchor),
            scaleScrollView.trailingAnchor.constraint(equalTo: scaleContainerView.trailingAnchor),
            scaleScrollView.topAnchor.constraint(equalTo: scaleContainerView.topAnchor),
            scaleScrollView.bottomAnchor.constraint(equalTo: scaleContainerView.bottomAnchor),
            
            // Scale content view
            scaleContentView.leadingAnchor.constraint(equalTo: scaleScrollView.leadingAnchor),
            scaleContentView.trailingAnchor.constraint(equalTo: scaleScrollView.trailingAnchor),
            scaleContentView.topAnchor.constraint(equalTo: scaleScrollView.topAnchor),
            scaleContentView.bottomAnchor.constraint(equalTo: scaleScrollView.bottomAnchor),
            scaleContentView.heightAnchor.constraint(equalTo: scaleScrollView.heightAnchor),
            
            // Center indicator
            centerIndicatorView.centerXAnchor.constraint(equalTo: scaleContainerView.centerXAnchor),
            centerIndicatorView.topAnchor.constraint(equalTo: scaleContainerView.topAnchor),
            centerIndicatorView.widthAnchor.constraint(equalToConstant: 2),
            centerIndicatorView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    // MARK: - Scale Setup
    private func setupScale() {
        let totalSteps = Int((maxWeight - minWeight) * 10) // 0.1 increments
        let contentWidth = CGFloat(totalSteps) * scaleSpacing + view.bounds.width
        
        scaleContentView.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
        scaleScrollView.contentSize = CGSize(width: contentWidth, height: 80)
        
        // Add padding to center the scale
        let padding = view.bounds.width / 2
        
        for i in 0...totalSteps {
            let weight = minWeight + Float(i) * 0.1
            let xPosition = padding + CGFloat(i) * scaleSpacing
            
            let scaleView = UIView()
            scaleView.backgroundColor = UIColor(red: 0.6, green: 0.4, blue: 1.0, alpha: 0.8)
            scaleView.translatesAutoresizingMaskIntoConstraints = false
            
            scaleContentView.addSubview(scaleView)
            scaleViews.append(scaleView)
            
            // Determine scale height based on weight value
            let isInteger = weight.truncatingRemainder(dividingBy: 1.0) == 0
            let isMultipleOfFive = Int(weight) % 5 == 0
            
            var scaleHeight: CGFloat
            if isInteger && isMultipleOfFive {
                scaleHeight = majorScaleHeight
            } else if isInteger {
                scaleHeight = majorScaleHeight * 0.7
            } else {
                scaleHeight = minorScaleHeight
            }
            
            NSLayoutConstraint.activate([
                scaleView.centerXAnchor.constraint(equalTo: scaleContentView.leadingAnchor, constant: xPosition),
                scaleView.bottomAnchor.constraint(equalTo: scaleContentView.bottomAnchor),
                scaleView.widthAnchor.constraint(equalToConstant: scaleWidth),
                scaleView.heightAnchor.constraint(equalToConstant: scaleHeight)
            ])
        }
    }
    
    // MARK: - Gesture Recognizers
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scaleScrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: scaleScrollView)
        let contentOffset = scaleScrollView.contentOffset.x
        let actualPosition = tapLocation.x + contentOffset
        
        // Calculate weight based on tap position
        let padding = view.bounds.width / 2
        let relativePosition = actualPosition - padding
        let stepIndex = Int(round(relativePosition / scaleSpacing))
        let targetWeight = minWeight + Float(stepIndex) * 0.1
        
        if targetWeight >= minWeight && targetWeight <= maxWeight {
            scrollToWeight(targetWeight, animated: true)
        }
    }
    
    // MARK: - Weight Scrolling
    private func scrollToWeight(_ weight: Float, animated: Bool) {
        let stepIndex = Int((weight - minWeight) * 10)
//        let padding = view.bounds.width / 2
        let targetOffset = CGFloat(stepIndex) * scaleSpacing
        
        scaleScrollView.setContentOffset(CGPoint(x: targetOffset, y: 0), animated: animated)
        
        currentWeight = weight
        updateWeightDisplay()
    }
    
    private func updateWeightDisplay() {
        // Smooth animation for weight change
        UIView.animate(withDuration: 0.2, animations: {
            self.weightLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.weightLabel.transform = .identity
            }
        }
        
        weightLabel.text = String(format: "%.1f", currentWeight)
    }
    
    private func updateScaleOpacity() {
        let centerOffset = scaleScrollView.contentOffset.x
//        let padding = view.bounds.width / 2
        
        for (index, scaleView) in scaleViews.enumerated() {
            let scalePosition = CGFloat(index) * scaleSpacing
            let distance = abs(scalePosition - centerOffset)
            let maxDistance: CGFloat = 100
            
            let opacity = max(0.3, 1.0 - (distance / maxDistance))
            scaleView.alpha = opacity
        }
    }
}

// MARK: - UIScrollViewDelegate
extension WeightpickVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.x
        let stepIndex = Int(round(contentOffset / scaleSpacing))
        let weight = minWeight + Float(stepIndex) * 0.1
        
        if weight >= minWeight && weight <= maxWeight && weight != currentWeight {
            currentWeight = weight
            updateWeightDisplay()
        }
        
        updateScaleOpacity()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            snapToNearestWeight()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToNearestWeight()
    }
    
    private func snapToNearestWeight() {
        let contentOffset = scaleScrollView.contentOffset.x
        let stepIndex = Int(round(contentOffset / scaleSpacing))
        let targetWeight = minWeight + Float(stepIndex) * 0.1
        
        if targetWeight >= minWeight && targetWeight <= maxWeight {
            scrollToWeight(targetWeight, animated: true)
        }
    }
}
