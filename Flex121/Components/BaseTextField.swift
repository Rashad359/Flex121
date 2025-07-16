//
//  BaseTextField.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/7/25.
//

import UIKit
import SkyFloatingLabelTextField

class BaseTextField: SkyFloatingLabelTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autocapitalizationType = .none
        titleFormatter = { $0 }
        selectedTitleColor = .main
        titleColor = .main
        textColor = .white
        backgroundColor = .background
        lineColor = .clear
        selectedLineColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
