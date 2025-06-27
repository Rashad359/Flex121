//
//  GenderVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/25/25.
//

import UIKit

final class GenderVC: BaseViewController {
    
    private let viewModel: GenderViewModel
    
    init(viewModel: GenderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private let TitleLabel: UILabel = {
        let label = UILabel()
        label.text = "tell us about yourself".uppercased()
        label.font = UIFont(name: Fonts.archivo.fontName, size: 20)
        label.textColor = .white
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "To give us a better experience we need to know your gender"
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
    
    private lazy var maleBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 66
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMale))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var femaleBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 66
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFemale))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private let maleLabel: UILabel = {
        let label = UILabel()
        label.text = "Male"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let maleGenderImage: UIImageView = {
        let image = UIImageView()
        image.image = .maleGender
        return image
    }()
    
    private let maleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let femaleLabel: UILabel = {
        let label = UILabel()
        label.text = "Female"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let femaleGenderImage: UIImageView = {
        let image = UIImageView()
        image.image = .femaleGender
        return image
    }()
    
    private let femaleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
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
    private func didTapFemale() {
        UIView.animate(withDuration: 0.5) {
            self.femaleBackground.backgroundColor = .main
            self.maleBackground.backgroundColor = .underline
        }
    }
    
    @objc
    private func didTapMale() {
        UIView.animate(withDuration: 0.5) {
            self.maleBackground.backgroundColor = .main
            self.femaleBackground.backgroundColor = .underline
        }
    }
    
    @objc
    private func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapNext() {
        //Push to next view controller
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
            make.horizontalEdges.equalToSuperview().inset(35)
        }
        
        view.addSubview(mainStackView)
        [maleBackground, femaleBackground].forEach(mainStackView.addArrangedSubview)
        mainStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        maleBackground.addSubview(maleStackView)
        [maleGenderImage, maleLabel].forEach(maleStackView.addArrangedSubview)
        maleBackground.snp.makeConstraints { make in
            make.size.equalTo(132)
        }
        maleStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        femaleBackground.addSubview(femaleStackView)
        [femaleGenderImage, femaleLabel].forEach(femaleStackView.addArrangedSubview)
        femaleBackground.snp.makeConstraints { make in
            make.size.equalTo(132)
        }
        femaleStackView.snp.makeConstraints { make in
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
