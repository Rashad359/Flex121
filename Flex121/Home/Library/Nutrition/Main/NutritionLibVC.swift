//
//  NutritionLibraryVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 8/21/25.
//

import UIKit

final class NutritionLibVC: BaseViewController {
    
    enum Cellhandler {
        case category([FoodCategory.Item])
        case catalogue([FoodCatalogue.Item])
    }
    
    private var allCells: [Cellhandler] = [
        .category([
            .init(name: "Food"),
            .init(name: "SomeFood"),
            .init(name: "OtherFood"),
            .init(name: "Food"),
            .init(name: "SomeFood"),
            .init(name: "OtherFood"),
            .init(name: "Food"),
            .init(name: "SomeFood"),
            .init(name: "OtherFood")
        ]),
        .catalogue([
            .init(foodImage: .salad, title: "Salad", subtitle: "subtitle for salad"),
            .init(foodImage: .redSalad, title: "Salad", subtitle: "subtitle for salad"),
            .init(foodImage: .librarySalad, title: "Salad", subtitle: "subtitle for salad"),
        ])
    ]
    
    private let viewModel: NutritionLibViewModel
    
    init(viewModel: NutritionLibViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FoodCategoryCell.self, forCellReuseIdentifier: FoodCategoryCell.identifier)
        tableView.register(FoodCatalogueCell.self, forCellReuseIdentifier: FoodCatalogueCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLeftNavButton()
        viewModel.getCategories()
    }
    
    private func setupUI() {
        title = "Nutrition library"
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = true
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}

extension NutritionLibVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = allCells[indexPath.row]
        switch myCell {
        case .category(let model):
            let cell: FoodCategoryCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            return cell
        case .catalogue(let model):
            let cell: FoodCatalogueCell = tableView.dequeueCell(for: indexPath)
            cell.configure(model)
            cell.subscribe(self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let myCell = allCells[indexPath.row]
        switch myCell {
        case .catalogue(_):
            return tableView.bounds.height
        default:
            return UITableView.automaticDimension
        }
    }
}

extension NutritionLibVC: FoodCatalogueDelegate {
    func navigation() {
        viewModel.goToDetails()
    }
}
