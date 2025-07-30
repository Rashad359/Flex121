//
//  ShippingVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/17/25.
//

import UIKit

class ShippingVC: BaseViewController {
    
    private let viewModel: ShippingViewModel
    
    init(viewModel: ShippingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(AddressCell.self, forCellReuseIdentifier: AddressCell.identifier)
        return tableView
    }()
    
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
        imageView.image = .plus
        return imageView
    }()
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLeftNavButton()
        setupRightNavButton()
    }
    
    override func setupLeftNavButton() {
        super.setupLeftNavButton()
    }
    
    private func setupRightNavButton() {
        rightBarView.addSubview(plusImage)
        plusImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPlus))
        rightBarView.addGestureRecognizer(tapGesture)
        let barButtonItem = UIBarButtonItem(customView: rightBarView)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc
    private func didTapPlus() {
        viewModel.goToAdd()
    }
    
//    private func setupNavigation() {
//        rightBarView.addSubview(plusImage)
//        plusImage.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPlus))
//        rightBarView.addGestureRecognizer(tapGesture)
//        let barButtonItem = UIBarButtonItem(customView: rightBarView)
////        barButtonItem.target = self
////        barButtonItem.action = #selector(didTapPlus)
//        navigationItem.rightBarButtonItem = barButtonItem
//    }
    
    private func setupUI() {
        title = "Shipping address"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
//    @objc
//    private func didTapPlus() {
//        viewModel.goToAdd()
//    }
}

extension ShippingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressCell = tableView.dequeueCell(for: indexPath)
        return cell
    }
}
