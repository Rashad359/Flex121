//
//  AddShippingVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/17/25.
//

import UIKit

class AddShippingVC: BaseViewController {
    
    enum CaseHandler {
        case info(InfoCell.Item)
        case picker(PickerCell.Item)
    }
    
    private var allCells: [CaseHandler] = [
        .info(.init(title: "Full name")),
        .info(.init(title: "Address")),
        .info(.init(title: "Zip code(Postal Code)")),
        .picker(.init(promptText: "Country", pickerData: ["Azerbaijan", "Turkiye", "United States"])),
        .picker(.init(promptText: "City", pickerData: ["Baku", "Shamakhi", "Gabala"])),
        .picker(.init(promptText: "District", pickerData: ["Nizami", "Khatai", "Other"])),
    ]
    
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
        tableView.register(PickerCell.self, forCellReuseIdentifier: PickerCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let saveButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Save address", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 16)
        button.layer.cornerRadius = 24
        button.backgroundColor = .main
        return button
    }()
    
    private let viewModel: AddShippingViewModel
    
    init(viewModel: AddShippingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNav()
        setupLeftNavButton()
        
    }
    
    override func setupLeftNavButton() {
        super.setupLeftNavButton()
        
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(saveButton)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        saveButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func setupNav() {
        title = "Add shipping address"
    }
}

extension AddShippingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = allCells[indexPath.row]
        switch myCell {
        case .info(let model):
            let cell: InfoCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .picker(let model):
            let cell: PickerCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        }
    }
}
