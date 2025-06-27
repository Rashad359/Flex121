//
//  PositionVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/25/25.
//

import UIKit

final class PositionVC: BaseViewController {
    
    
    private let viewModel: PositionViewModel
    
    init(viewModel: PositionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Something went wrong")
    }
    
    private let TitleLabel: UILabel = {
        let label = UILabel()
        label.text = "what's your current position?".uppercased()
        label.font = UIFont(name: Fonts.archivo.fontName, size: 20)
        label.textColor = .white
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "To give us a better experience we need to know your position"
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
    
    private lazy var trainerBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 66
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTrainer))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var EnthusiastBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 66
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapEnthusiast))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private let trainerLabel: UILabel = {
        let label = UILabel()
        label.text = "Trainer"
        label.font = UIFont(name: Fonts.archivo.fontName, size: 18)
        label.textColor = .white
        return label
    }()
    
    private let enthusiastLabel: UILabel = {
        let label = UILabel()
        label.text = "Enthusiast"
        label.font = UIFont(name: Fonts.archivo.fontName, size: 18)
        label.textColor = .white
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 42
        return stackView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.arrowLeft, for: .normal)
        button.backgroundColor = .dark3
        button.layer.cornerRadius = 25
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
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
    private func didTapEnthusiast() {
        UIView.animate(withDuration: 0.5) {
            self.EnthusiastBackground.backgroundColor = .main
            self.trainerBackground.backgroundColor = .underline
        }
    }
    
    @objc
    private func didTapTrainer() {
        UIView.animate(withDuration: 0.5) {
            self.trainerBackground.backgroundColor = .main
            self.EnthusiastBackground.backgroundColor = .underline
        }
    }
    
    @objc
    private func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapNext() {
        //Push to next view controller
        viewModel.goToGender()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        view.addSubview(textStackView)
        [TitleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        textStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(36)
            make.horizontalEdges.equalToSuperview().inset(52)
        }
        
        view.addSubview(mainStackView)
        [trainerBackground, EnthusiastBackground].forEach(mainStackView.addArrangedSubview)
        mainStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        trainerBackground.addSubview(trainerLabel)
        trainerBackground.snp.makeConstraints { make in
            make.size.equalTo(132)
        }
        trainerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        EnthusiastBackground.addSubview(enthusiastLabel)
        EnthusiastBackground.snp.makeConstraints { make in
            make.size.equalTo(132)
        }
        enthusiastLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(bottomStackView)
        [backButton, nextButton].forEach(bottomStackView.addArrangedSubview)
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
    }
}
