//
//  ProfileVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/14/25.
//

import UIKit

class ProfileVC: BaseViewController {
    
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    enum cellHandler {
        case top(TopCell.Item)
        case metric([MetricsCell.Item])
        case editButton
        case settings(SettingsCell.Item)
    }
    
    private var allCells: [cellHandler] = [
        .top(.init(userName: "Some user")),
        .metric([
            .init(titleText: "Age", number: "19"),
            .init(titleText: "Height", number: "158 cm"),
            .init(titleText: "Weight", number: "46 kg")
        ]),
        .editButton,
        .settings(.init(title: "My orders", subtitle: "Already have 10 orders")),
        .settings(.init(title: "Shipping addresses", subtitle: "2 addresses")),
        .settings(.init(title: "Payment method", subtitle: "You have 3 cards")),
        .settings(.init(title: "Settings", subtitle: "Notification, Password, FAQ, Contact"))
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TopCell.self, forCellReuseIdentifier: TopCell.identifier)
        tableView.register(HorizontalMetricsCell.self, forCellReuseIdentifier: HorizontalMetricsCell.identifier)
        tableView.register(EditPofileCell.self, forCellReuseIdentifier: EditPofileCell.identifier)
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
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

    private let quitImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "door.left.hand.open")
        imageView.tintColor = .white
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNav()
        setupLeftNavButton()
        setupRightNavButton()
        viewModel.subscribe(self)
        viewModel.getUserName()
        viewModel.fetchBiometrics()
    }
    
    func setupRightNavButton() {
        rightBarView.addSubview(quitImage)
        quitImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapQuit))
        rightBarView.addGestureRecognizer(tapGesture)
        let barButtonItem = UIBarButtonItem(customView: rightBarView)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc
    private func didTapQuit() {
        viewModel.logOut()
    }
    
    override func setupLeftNavButton() {
        super.setupLeftNavButton()
    }
    
    private func setupNav() {
        title = "Profile"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = allCells[indexPath.row]
        switch myCell {
        case .top(let model):
            let cell: TopCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .metric(let model):
            let cell: HorizontalMetricsCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .editButton:
            let cell: EditPofileCell = tableView.dequeueCell(for: indexPath)
            cell.goToSettings = {[weak self] in
                self?.viewModel.goToSettings()
            }
            return cell
        case .settings(let model):
            let cell: SettingsCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let myCell = allCells[indexPath.row]
        switch myCell {
        case .metric(_):
            return 90
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myCell = allCells[indexPath.row]
        switch myCell {
        case .settings(let model):
            switch model.title {
            case "My orders":
                viewModel.goToOrders()
            case "Shipping addresses":
                viewModel.goToShipping()
            case "Payment method":
                viewModel.goToPayment()
            case "Settings":
                viewModel.navToSettings()
            default:
                return
            }
        default:
            return
        }
    }
}

extension ProfileVC: ProfileViewDelegate {
    
    func didGetName(_ data: [String : Any]) {
        guard let name = data["name"] as? String else { return }
        
        if let index = self.allCells.firstIndex(where: {
            if case .top = $0 { return true }
            return false
        }) {
            if case .top(var model) = self.allCells[index] {
                model.userName = name
                self.allCells[index] = .top(model)
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didGetBio(_ data: [String : Any]) {
        guard let age = data["age"] as? Int,
              let height = data["height"] as? Int,
              let weight = data["weight"] as? Int else { return }
        
        if let index = self.allCells.firstIndex(where: {
            if case .metric = $0 { return true }
            return false
        }) {
            if case .metric(var model) = self.allCells[index] {
                model[0].number = "\(age)"
                model[1].number = "\(height) cm"
                model[2].number = "\(weight) kg"
                self.allCells[index] = .metric(model)
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func error(_ error: any Error) {
        print(error.localizedDescription)
    }
}
