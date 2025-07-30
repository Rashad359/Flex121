//
//  BaseViewController.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 5/13/25.
//

import UIKit
import SnapKit
import FirebaseFirestore

class BaseViewController: UIViewController {
    
    private let rightBarView: UIView = {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
        view.backgroundColor = .underline
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let plusImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .chevronLeft
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
    }
    
    func setupLeftNavButton() {
        rightBarView.addSubview(plusImage)
        plusImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBack))
        rightBarView.addGestureRecognizer(tapGesture)
        let barButtonItem = UIBarButtonItem(customView: rightBarView)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc
    private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    
}
