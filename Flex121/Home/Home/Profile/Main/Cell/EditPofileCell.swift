//
//  EditPofileCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/15/25.
//

import UIKit

class EditPofileCell: UITableViewCell {
    
    var goToSettings: (() -> ())?
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit profile", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .main
        button.titleLabel?.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        button.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func didTapEdit() {
        goToSettings?()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(editProfileButton)
        editProfileButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(48)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
