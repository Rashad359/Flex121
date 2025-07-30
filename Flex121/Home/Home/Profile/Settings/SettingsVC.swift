import UIKit

class SettingsVC: BaseViewController {
    
    private let viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
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
        setupLeftNavButton()
        
    }
    
    override func setupLeftNavButton() {
        super.setupLeftNavButton()
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
            cell.subscribe(self)
            return cell
        case .config(let model):
            let cell: ConfigCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        }
    }
}


extension SettingsVC: InputCellDelegate {
    func changeEmail(_ email: String) {
        let alert = UIAlertController(title: "Change Email", message: "Please provide your current password", preferredStyle: .alert)
        alert.addTextField()
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let confirm = UIAlertAction(title: "Update", style: .default) { [weak self] item in
            guard let alertText = alert.textFields?.first?.text else { return }
            self?.viewModel.changeEmail(with: alertText, to: email)
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        self.present(alert, animated: true)
    }
    
    func changeName(_ name: String) {
        viewModel.changeName(to: name)
    }
}
