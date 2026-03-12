//
//  HomeController.swift
//  NewspaperApp
//
//  Created by user on 03.03.26.
//

import UIKit

class HomeController: BaseController {
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = .systemBackground
        t.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func configureUI() {
        view.addSubview(table)
    }
    
    override func configureViewModel() {
        viewModel.getNewsList()
        viewModel.success = { [weak self] in
            print("Xeberler geldi. Meqalelerin sayi: \(self?.viewModel.articles.count ?? 0)")
            self?.table.reloadData()
        }
        viewModel.error = { errorMessage in
            print(errorMessage)
        }
    }
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension HomeController: TableConfigure {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.articles[indexPath.row].title
        return cell
    }
}
