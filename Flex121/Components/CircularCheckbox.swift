//
//  CircularCheckbox.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/17/25.
//

import UIKit

class CircularCheckbox: UIView {
    
    private var isChecked = true
    
    private var checkBox: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .checkMark
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.underline.cgColor
        layer.cornerRadius = frame.size.width / 2.0
        backgroundColor = .clear
        
        addSubview(checkBox)
        checkBox.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func toggle() {
        self.isChecked = !isChecked
        
        if self.isChecked {
            checkBox.isHidden = false
        } else {
            checkBox.isHidden = true
            backgroundColor = .clear
        }
    }
}
