

import UIKit

class WeightPickerViewController: BaseViewController  {
    
    private let scrollView = UIScrollView()
    private let rulerView = UIStackView()
    private let weightLabel = UILabel()
    private let centerLine = UIView()
    
    private let minWeight = 20
    private let maxWeight = 150
    private let markSpacing: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupWeightLabel()
        setupScrollView()
//        setupCenterLine()
        createRulerMarks()
    }
    
    private func setupWeightLabel() {
        weightLabel.text = "46 kg"
        weightLabel.textColor = .white
        weightLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weightLabel)
        
        NSLayoutConstraint.activate([
            weightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60)
        ])
    }
    
    private func setupScrollView() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.decelerationRate = .fast
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        rulerView.axis = .horizontal
        rulerView.alignment = .bottom
        rulerView.distribution = .equalSpacing
        rulerView.spacing = markSpacing
        rulerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(rulerView)
        
        NSLayoutConstraint.activate([
            rulerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            rulerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            rulerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            rulerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            rulerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    private func createRulerMarks() {
        // Add padding at the start
        let leftPadding = UIView()
        leftPadding.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        rulerView.addArrangedSubview(leftPadding)
        
        for i in minWeight...maxWeight {
            let mark = UIView()
            mark.backgroundColor = .systemPurple
            let height: CGFloat = (i % 5 == 0) ? 40 : 20
            mark.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                mark.widthAnchor.constraint(equalToConstant: 2),
                mark.heightAnchor.constraint(equalToConstant: height)
            ])
            rulerView.addArrangedSubview(mark)
        }
        
        // Add padding at the end
        let rightPadding = UIView()
        rightPadding.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        rulerView.addArrangedSubview(rightPadding)
    }
    
    private func setupCenterLine() {
        centerLine.backgroundColor = .systemPurple
        centerLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerLine)
        
        NSLayoutConstraint.activate([
            centerLine.widthAnchor.constraint(equalToConstant: 2),
            centerLine.heightAnchor.constraint(equalToConstant: 60),
            centerLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerLine.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    }
}

extension WeightPickerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + (view.frame.width / 2)
        let index = Int(round(offsetX / markSpacing))
        let value = min(max(index + minWeight - 1, minWeight), maxWeight)
        weightLabel.text = "\(value) kg"
    }
}
