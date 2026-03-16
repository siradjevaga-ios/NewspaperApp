//
//  HomeController.swift
//  NewspaperApp
//
//  Created by user on 03.03.26.
//

import UIKit

class HomeController: BaseController {
    
    private lazy var categoryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        return cv
    }()
    
    private let categories = ["General", "Business", "Technology", "Sports", "Science", "Health"]
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = .systemBackground
        t.register(HomeNewsCell.self, forCellReuseIdentifier: "HomeNewsCell")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let viewModel: HomeViewModel
    
    private var selectedCategory: String = "General"
    
    private var selectedCategoryIndex: Int = 0

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
        view.addSubview(categoryCollection)
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
            categoryCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollection.heightAnchor.constraint(equalToConstant: 48),
            
            table.topAnchor.constraint(equalTo: categoryCollection.bottomAnchor, constant: 12),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension HomeController: TableConfigure, CollectionConfigure {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath)
        cell.backgroundColor = .systemBlue
        cell.layer.cornerRadius = 16
        
        
        
        let label = UILabel(frame: cell.contentView.bounds)
        label.text = categories[indexPath.item]
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.contentView.addSubview(label)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 100, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        selectedCategoryIndex = indexPath.item
        viewModel.getNewsList(category: selectedCategory.lowercased())
        collectionView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNewsCell", for: indexPath) as! HomeNewsCell
        let article = viewModel.articles[indexPath.row]
        cell.setCell(item: article, category: selectedCategory)
        return cell
    }
}


