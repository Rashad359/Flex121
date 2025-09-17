//
//  DetailVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 9/8/25.
//

import UIKit

final class DetailsVC: BaseViewController {
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    private let mealImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .salad
        
        return imageView
    }()
    
    private let titleLabel: BaseLabel = {
        let label = BaseLabel()
        label.text = "Frest Fruit Salad"
        label.textColor = .softYellow
        
        return label
    }()
    
    private let subtitleView: UIView = {
        let view = UIView()
        view.backgroundColor = .softYellow
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    private let proteinLabel: BaseLabel = {
        let label = BaseLabel()
        label.text = "Protein"
        label.textColor = .black
        
        return label
    }()
    
    private let proteinNumber: UILabel = {
        let label = UILabel()
        label.text = "450g"
        label.textColor = .black
        
        return label
    }()
    private let proteinStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 4
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let caloriesLabel: BaseLabel = {
        let label = BaseLabel()
        label.text = "Calories"
        label.textColor = .black
        
        return label
    }()
    
    private let caloriesNumber: UILabel = {
        let label = UILabel()
        label.text = "220g"
        label.textColor = .black
        
        return label
    }()
    
    private let caloriesStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 4
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let fatsLabel: BaseLabel = {
        let label = BaseLabel()
        label.text = "Fats"
        label.textColor = .black
        
        return label
    }()
    
    private let fatsNumber: UILabel = {
        let label = UILabel()
        label.text = "100g"
        label.textColor = .black
        
        return label
    }()
    
    private let fatsStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 4
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let carbsLabel: BaseLabel = {
        let label = BaseLabel()
        label.text = "Carbs"
        label.textColor = .black
        
        return label
    }()
    
    private let carbsNumber: UILabel = {
        let label = UILabel()
        label.text = "49g"
        label.textColor = .black
        
        return label
    }()
    
    private let carbsStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 4
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let subStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 25
        
        return stackView
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Details"
        label.textColor = .softGreen
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Caesar salad is made with romaine lettuce, croutons, Parmesan cheese, and Caesar dressing. The mixture of olive oil, lemon juice, Worcestershire sauce, Dijon mustard, and garlic."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = .zero
        
        return label
    }()
    
    private let descStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let addButton: BaseButton = {
        let button = BaseButton(type: .system)
        button.setTitle("Add to diet", for: .normal)
        button.layer.cornerRadius = 24
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .main
        button.titleLabel?.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLeftNavButton()
    }
    
    private func setupUI() {
        view.addSubview(mainView)
        
        view.addSubview(descStackView)
        [detailsLabel, descriptionLabel].forEach(descStackView.addArrangedSubview)
        
        view.addSubview(addButton)
        
        [mealImage, titleLabel, subtitleView].forEach(mainView.addSubview)
        subtitleView.addSubview(subStackView)
        
        [proteinLabel, proteinNumber].forEach(proteinStackView.addArrangedSubview)
        [caloriesLabel, caloriesNumber].forEach(caloriesStackView.addArrangedSubview)
        [fatsLabel, fatsNumber].forEach(fatsStackView.addArrangedSubview)
        [carbsLabel, carbsNumber].forEach(carbsStackView.addArrangedSubview)
        
        [proteinStackView, caloriesStackView, fatsStackView, carbsStackView].forEach(subStackView.addArrangedSubview)
        
        mealImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.horizontalEdges.equalToSuperview().inset(54)
            make.height.equalTo(218)
            make.width.equalTo(195)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subtitleView.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(24)
        }
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(400) // for now
        }
        
        subtitleView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(86)
        }
        
        subStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.leading.equalToSuperview().offset(24)
        }
        
        descStackView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-14)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
    }
}
