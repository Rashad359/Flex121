//
//  BaseTextField.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 6/7/25.
//

import UIKit
import SkyFloatingLabelTextField

class BaseTextField: SkyFloatingLabelTextField {
    
    private lazy var toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.items = [
            .init(
                title: "Done",
                style: .done,
                target: self,
                action: #selector(didTapDone)
            )
        ]
        return toolbar
    }()
    
    @objc
    private func didTapDone() {
        endEditing(true)
    }
    
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
        
        inputAccessoryView = toolBar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
