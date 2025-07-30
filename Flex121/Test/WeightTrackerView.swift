import UIKit

class WeightPickerView: UIView {
    
    // MARK: - Properties
    private var scrollView: UIScrollView!
    private var weightLabel: UILabel!
    private var unitLabel: UILabel!
    private var scaleView: WeightScaleView!
    private var selectionFeedbackGenerator: UISelectionFeedbackGenerator!
    
    // Weight picker properties
    private let minWeight: Double = 30.0
    private let maxWeight: Double = 200.0
    private let weightIncrement: Double = 0.1
    private let pixelsPerKg: CGFloat = 50.0
    
    private var currentWeight: Double = 46.0 {
        didSet {
            updateWeightDisplay()
            onWeightChanged?(currentWeight)
        }
    }
    
    // Callbacks
    var onWeightChanged: ((Double) -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
        selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        
        setupWeightLabel()
        setupUnitLabel()
        setupScrollView()
        setupScaleView()
        setupConstraints()
        
        // Set initial scroll position
        DispatchQueue.main.async {
            self.scrollToWeight(self.currentWeight, animated: false)
        }
    }
    
    private func setupWeightLabel() {
        weightLabel = UILabel()
        weightLabel.text = "46"
        weightLabel.textColor = .white
        weightLabel.font = UIFont.systemFont(ofSize: 120, weight: .bold)
        weightLabel.textAlignment = .center
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weightLabel)
    }
    
    private func setupUnitLabel() {
        unitLabel = UILabel()
        unitLabel.text = "kg"
        unitLabel.textColor = .white
        unitLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        unitLabel.textAlignment = .left
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(unitLabel)
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
    }
    
    private func setupScaleView() {
        scaleView = WeightScaleView()
        scaleView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(scaleView)
        
        // Calculate content size
        let totalRange = maxWeight - minWeight
        let contentWidth = CGFloat(totalRange) * pixelsPerKg
        
        scrollView.contentSize = CGSize(width: contentWidth, height: 0)
        scaleView.frame = CGRect(x: 0, y: 0, width: contentWidth, height: 80)
        scaleView.setupScale(minWeight: minWeight, maxWeight: maxWeight, pixelsPerKg: pixelsPerKg)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Weight label - centered
            weightLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -20),
            weightLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
            
            // Unit label - positioned to the right and bottom of weight
            unitLabel.leadingAnchor.constraint(equalTo: weightLabel.trailingAnchor, constant: 8),
            unitLabel.bottomAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: -10),
            
            // ScrollView - below weight label, full width
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 60),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    // MARK: - Weight Management
    private func updateWeightDisplay() {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 0
        
        weightLabel.text = formatter.string(from: NSNumber(value: currentWeight))
    }
    
    private func scrollToWeight(_ weight: Double, animated: Bool) {
        let clampedWeight = max(minWeight, min(maxWeight, weight))
        let weightOffset = clampedWeight - minWeight
        let xOffset = CGFloat(weightOffset) * pixelsPerKg - (scrollView.bounds.width / 2)
        
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: animated)
    }
    
    private func weightFromScrollOffset(_ offset: CGFloat) -> Double {
        let adjustedOffset = offset + (scrollView.bounds.width / 2)
        let weightOffset = Double(adjustedOffset / pixelsPerKg)
        return max(minWeight, min(maxWeight, minWeight + weightOffset))
    }
    
    // MARK: - Public Methods
    func setWeight(_ weight: Double, animated: Bool = true) {
        currentWeight = weight
        scrollToWeight(weight, animated: animated)
    }
    
    func getCurrentWeight() -> Double {
        return currentWeight
    }
}

// MARK: - ScrollView Delegate
extension WeightPickerView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newWeight = weightFromScrollOffset(scrollView.contentOffset.x)
        let roundedWeight = round(newWeight / weightIncrement) * weightIncrement
        
        if abs(currentWeight - roundedWeight) >= weightIncrement {
            currentWeight = roundedWeight
            selectionFeedbackGenerator.selectionChanged()
        }
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
        let currentScrollWeight = weightFromScrollOffset(scrollView.contentOffset.x)
        let snappedWeight = round(currentScrollWeight / weightIncrement) * weightIncrement
        scrollToWeight(snappedWeight, animated: true)
    }
}

// MARK: - Weight Scale View
class WeightScaleView: UIView {
    
    private var tickLayers: [CAShapeLayer] = []
    
    func setupScale(minWeight: Double, maxWeight: Double, pixelsPerKg: CGFloat) {
        // Clear existing ticks
        tickLayers.forEach { $0.removeFromSuperlayer() }
        tickLayers.removeAll()
        
        let totalRange = maxWeight - minWeight
        let totalTicks = Int(totalRange * 10) // One tick per 0.1 kg
        
        for i in 0..<totalTicks {
            let weight = minWeight + Double(i) * 0.1
            let x = CGFloat(weight - minWeight) * pixelsPerKg
            
            let tickLayer = CAShapeLayer()
            tickLayer.fillColor = UIColor.systemPurple.cgColor
            
            // Make every 10th tick (whole kg) taller
            let isWholeKg = Int(weight * 10) % 10 == 0
            let tickHeight: CGFloat = isWholeKg ? 40 : 20
            let tickWidth: CGFloat = 2
            
            let tickPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: tickWidth, height: tickHeight))
            tickLayer.path = tickPath.cgPath
            tickLayer.frame = CGRect(x: x - tickWidth/2, y: (bounds.height - tickHeight) / 2, width: tickWidth, height: tickHeight)
            
            layer.addSublayer(tickLayer)
            tickLayers.append(tickLayer)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Recreate scale when bounds change
        if !tickLayers.isEmpty {
            // Re-setup with current parameters - you'd need to store these
            setupScale(minWeight: 30.0, maxWeight: 200.0, pixelsPerKg: 50.0)
        }
    }
}

// MARK: - Usage Example
class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weightPicker = WeightPickerView()
        weightPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weightPicker)
        
        NSLayoutConstraint.activate([
            weightPicker.topAnchor.constraint(equalTo: view.topAnchor),
            weightPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weightPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weightPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Handle weight changes
        weightPicker.onWeightChanged = { weight in
            print("Weight changed to: \(weight) kg")
        }
        
        // Set initial weight
        weightPicker.setWeight(46.0)
    }
}
