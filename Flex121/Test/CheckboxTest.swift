//
//  CheckboxTest.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/17/25.
//

import UIKit

class CheckboxTest: BaseViewController {
    
    private lazy var checkbox: CircularCheckbox = {
        let view = CircularCheckbox()
        view.layer.cornerRadius = 12
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    @objc
    private func didTap() {
        checkbox.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(checkbox)
        checkbox.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(24)
        }
        
    }
}
