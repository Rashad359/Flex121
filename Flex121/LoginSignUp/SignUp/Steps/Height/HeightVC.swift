//
//  HeightVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/7/25.
//
import UIKit

final class HeightVC: BaseViewController {
    
    private let viewModel: HeightViewModel
    
    init(viewModel: HeightViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let numbers = Array(100...250)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "what's your height?".uppercased()
        label.font = UIFont(name: Fonts.archivo.fontName, size: 20)
        label.textColor = .white
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "This helps us to provids a personalized plan"
        label.font = UIFont(name: Fonts.archivo.fontName, size: 12)
        label.textColor = .white
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
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
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.arrowLeft, for: .normal)
        button.backgroundColor = .dark3
        button.layer.cornerRadius = 25
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapBackk), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.archivo.fontName, size: 16)
        button.tintColor = .white
        button.layer.cornerRadius = 16
        button.backgroundColor = .main
        button.widthAnchor.constraint(greaterThanOrEqualToConstant: 124).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        return button
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    @objc
    private func didTapBackk() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapNext() {
        viewModel.goToGoal()
        let height = pickerView.selectedRow(inComponent: 0) + numbers[0]
        viewModel.addHeight(height: height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(textStackView)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        textStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(36)
            make.horizontalEdges.equalToSuperview().inset(35)
        }
        
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(135)
            make.height.equalTo(350)
        }
        
        [topLine, bottomLine].forEach(view.addSubview)
        topLine.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(113)
            make.centerX.equalTo(pickerView.snp.centerX)
            make.centerY.equalTo(pickerView.snp.centerY).offset(-38)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(113)
            make.centerX.equalTo(pickerView.snp.centerX)
            make.centerY.equalTo(pickerView.snp.centerY).offset(38)
        }
        
        view.addSubview(bottomStackView)
        [backButton, nextButton].forEach(bottomStackView.addArrangedSubview)
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
    }
}

extension HeightVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 70
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = "\(numbers[row])"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textColor = .white
        
        return label
    }
    
    
}
