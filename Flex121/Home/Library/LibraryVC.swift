//
//  LibraryVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/9/25.
//

import UIKit

class LibraryVC: BaseViewController {
    
//    let searchBar: UISearchBar = {
//        let searchBar = UISearchBar()
//        searchBar.placeholder = "Search for food"
//        return searchBar
//    }()
    
    enum CaseHandler {
        case entry(LibraryEntryCell.Item)
        case category([AllFoodCell.Item])
    }
    
    private var item: [CaseHandler] = [
        .entry(.init(entryName: "All food")),
        
        .category([
            .init(title: "Ceaser's Salad", calories: "1380 Calories", protein: "5mg Protein", foodImage: .librarySalad),
            .init(title: "Fruit Salad", calories: "1380 Calories", protein: "5mg Protein", foodImage: .librarySalad)
        ]),
        
        .entry(.init(entryName: "Recommended for you")),
        
        .category([
            .init(title: "Cookies", calories: "1380 Calories", protein: "5mg Protein", foodImage: .cookie),
            .init(title: "Fruit Salad", calories: "1380 Calories", protein: "5mg Protein", foodImage: .librarySalad)
        ])
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(LibraryEntryCell.self, forCellReuseIdentifier: LibraryEntryCell.identifier)
        tableView.register(HorizontalFoodCell.self, forCellReuseIdentifier: HorizontalFoodCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        title = "Library"
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension LibraryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = item[indexPath.row]
        switch myCell {
        case .entry(let model):
            let cell: LibraryEntryCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .category(let model):
            let cell: HorizontalFoodCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let myCell = item[indexPath.row]
        switch myCell {
        case .category(_):
            return 160
        default:
            return UITableView.automaticDimension
        }
    }
}
