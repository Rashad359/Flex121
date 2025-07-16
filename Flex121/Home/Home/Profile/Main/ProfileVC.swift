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
        case top
        case metric([MetricsCell.Item])
        case editButton
        case settings(SettingsCell.Item)
    }
    
    private let allCells: [cellHandler] = [
        .top,
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigation()
    }
    
    private func setupNavigation() {
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
        case .top:
            let cell: TopCell = tableView.dequeueCell(for: indexPath)
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
            default:
                return
            }
        default:
            return
        }
    }
}
