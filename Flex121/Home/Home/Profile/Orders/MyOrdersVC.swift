//
//  MyOrders.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/16/25.
//

import UIKit

class MyOrdersVC: BaseViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrdersCell.self, forCellReuseIdentifier: OrdersCell.identifier)
        return tableView
    }()
    
    private let deliveredLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivered"
        label.textColor = .white
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        return label
    }()
    
    private let processingLabel: UILabel = {
        let label = UILabel()
        label.text = "Processing"
        label.textColor = .white
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        return label
    }()
    
    private let cancelledLabel: UILabel = {
        let label = UILabel()
        label.text = "Cancelled"
        label.textColor = .white
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        return label
    }()
    
    private let topStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        title = "My orders"
        view.addSubview(topStackView)
        view.addSubview(tableView)
        [deliveredLabel, processingLabel, cancelledLabel].forEach(topStackView.addArrangedSubview)
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(tableView.snp.top).offset(-24)
        }
        tableView.snp.makeConstraints { make in
//            make.top.equalTo(topStackView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MyOrdersVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrdersCell = tableView.dequeueCell(for: indexPath)
        return cell
    }
    
    
}
