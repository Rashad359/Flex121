import UIKit

class SettingsVC: BaseViewController {
    
    enum cellHandler {
        case title(TitleCell.Item)
        case input(InputCell.Item)
        case config(ConfigCell.Item)
    }
    
    private var allCells: [cellHandler] = [
        .title(.init(title: "Personal information")),
        .input(.init(placeholder: "Name")),
        .input(.init(placeholder: "Email")),
        .title(.init(title: "Password")),
        .input(.init(placeholder: "Password")),
        .config(.init(title: "Dark mode", isSwitchShown: true, isChevronShown: false)),
        .config(.init(title: "Notifications", isSwitchShown: false, isChevronShown: true)),
        .config(.init(title: "FAQ", isSwitchShown: false, isChevronShown: true)),
        .config(.init(title: "Contact us", isSwitchShown: false, isChevronShown: true)),
        .config(.init(title: "Privacy & Terms", isSwitchShown: false, isChevronShown: true)),
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
        tableView.register(InputCell.self, forCellReuseIdentifier: InputCell.identifier)
        tableView.register(ConfigCell.self, forCellReuseIdentifier: ConfigCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        title = "Settings"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SettingsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = allCells[indexPath.row]
        switch myCell {
        case .title(let model):
            let cell: TitleCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .input(let model):
            let cell: InputCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .config(let model):
            let cell: ConfigCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        }
    }
}
