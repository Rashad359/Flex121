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
    
    private var items:[AddressCell.Item] = []
    
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
        setupNotificationCenter()
        items = viewModel.getList()
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification),
            name: Notification.Name("test"),
            object: nil
        )
    }
    
    @objc
    private func handleNotification(_ sender: Notification) {
        
        self.items.insert(
            .init(
                customerName: sender.userInfo?["name"] as? String ?? "",
                address: sender.userInfo?["address"] as? String ?? "",
                zipCode: sender.userInfo?["zipCode"] as? String ?? "",
                country: sender.userInfo?["country"] as? String ?? "",
                city: sender.userInfo?["city"] as? String ?? "",
                district: sender.userInfo?["district"] as? String ?? ""
            ),
            at: 0
        )
        
        viewModel.saveList(items)
        
        self.tableView.reloadData()
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
    
    private func setupUI() {
        title = "Shipping address"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ShippingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressCell = tableView.dequeueCell(for: indexPath)
        cell.configure(items[indexPath.row])
        return cell
    }
}
