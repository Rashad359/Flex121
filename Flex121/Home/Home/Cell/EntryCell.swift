//
//  CalendarEntryCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/9/25.
//

import UIKit

class EntryCell: UICollectionViewCell {
    
    private let entryLabel: UILabel = {
        let label = UILabel()
        label.text = "Calendar"
        label.textColor = .white
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 17)
        return label
    }()
    
    private let forwardIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .chevronLeft
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(stackView)
        [entryLabel, forwardIcon].forEach(stackView.addArrangedSubview)
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EntryCell {
    struct Item {
        let entryName: String
    }
    
    func configure(_ item: Item) {
        entryLabel.text = item.entryName
    }
}
