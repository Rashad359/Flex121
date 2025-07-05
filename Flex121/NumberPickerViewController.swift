//
//  TestScreen.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/5/25.
//

import UIKit

class NumberPickerViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
//        pickerView.backgroundColor = .black
        return pickerView
    }()
    
    private let linesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 82
        return stackView
    }()
    
    private let topLine: UIView = {
        let topline = UIView()
        topline.backgroundColor = .main
        topline.translatesAutoresizingMaskIntoConstraints = false
        topline.heightAnchor.constraint(equalToConstant: 3).isActive = true
        topline.widthAnchor.constraint(equalToConstant: 113).isActive = true
        return topline
    }()
    
    private let bottomLine: UIView = {
        let botline = UIView()
        botline.backgroundColor = .main
        botline.translatesAutoresizingMaskIntoConstraints = false
        botline.heightAnchor.constraint(equalToConstant: 3).isActive = true
        return botline
    }()
    
    let numbers = Array(1...200)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addHighlightLines()
    }
    
    private func setupUI() {
        view.addSubview(pickerView)
        view.addSubview(linesStackView)
        [topLine, bottomLine].forEach(linesStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 350),
            
            linesStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            linesStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func addHighlightLines() {
//            let lineColor = UIColor.systemPurple
//            let lineHeight: CGFloat = 1

//            let topLine = UIView()
//            topLine.backgroundColor = lineColor
//            topLine.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(topLine)

//            let bottomLine = UIView()
//            bottomLine.backgroundColor = lineColor
//            bottomLine.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(bottomLine)

            NSLayoutConstraint.activate([
                
                
//                topLine.heightAnchor.constraint(equalToConstant: lineHeight),
//                topLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//                topLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//                topLine.centerYAnchor.constraint(equalTo: pickerView.centerYAnchor, constant: -25),
                

//                bottomLine.heightAnchor.constraint(equalToConstant: lineHeight),
//                bottomLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//                bottomLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//                bottomLine.centerYAnchor.constraint(equalTo: pickerView.centerYAnchor, constant: 25)
            ])
        }

    
        // MARK: - UIPickerView DataSource & Delegate
    
    var selectedIndex = 1

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return numbers.count
        }

        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 70
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
        pickerView.reloadComponent(component)
    }

        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let label = UILabel()
            label.text = "\(numbers[row])"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: row == selectedIndex ? 40 : 28, weight: .bold)
            label.textColor = .white

            // Fade effect (optional for extra polish)
//            let selectedRow = pickerView.selectedRow(inComponent: component)
            let distance = abs(row - selectedIndex)
            switch distance {
            case 0:
                label.alpha = 1.0
            case 1:
                label.alpha = 0.6
            default:
                label.alpha = 0.3
            }

            return label
        }
}

//#Preview {
//    NumberPickerViewController()
//}
