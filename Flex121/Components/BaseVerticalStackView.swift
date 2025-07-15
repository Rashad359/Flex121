//
//  BaseVerticalStackView.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/14/25.
//

import UIKit

class BaseVerticalStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    private func setup() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
