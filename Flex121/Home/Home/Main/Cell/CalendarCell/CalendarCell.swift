//
//  CalendarCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/10/25.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    private let calendarView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .underline
        return view
    }()
    
    private let dayOfTheWeek: UILabel = {
        let label = UILabel()
        label.text = "Sun"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let monthNumber: UILabel = {
        let label = UILabel()
        label.text = "13"
        label.textColor = .white
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 20)
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 3
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(calendarView)
        calendarView.addSubview(mainStackView)
        [dayOfTheWeek, monthNumber].forEach(mainStackView.addArrangedSubview)
        mainStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        calendarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(68)
            make.width.equalTo(56)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalendarCell {
    struct Item {
        let date: String
        let dayOfWeek: String
    }
    
    func configure(_ item: Item) {
        dayOfTheWeek.text = item.dayOfWeek
        monthNumber.text = item.date
    }
}
