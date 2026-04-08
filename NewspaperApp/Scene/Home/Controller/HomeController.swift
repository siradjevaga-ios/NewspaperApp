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
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let categories = ["General", "Business", "Technology", "Sports", "Science", "Health"]
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = .systemBackground
        t.register(HomeNewsCell.self, forCellReuseIdentifier: "HomeNewsCell")
        t.showsVerticalScrollIndicator = false
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
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "The Readline"
    }
    
    override func configureUI() {
        view.addSubview(categoryCollection)
        view.addSubview(table)
        configureNavItems()
        categoryCollection.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func configureViewModel() {
        viewModel.getNewsList()
        viewModel.success = { [weak self] in
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        }
        viewModel.error = { print($0) }
        viewModel.onLogoutSuccess = { [weak self] in
            if let sceneDelegate = self?.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.goToLoginPage()
            }
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
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureNavItems() {
        let searchItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(handleSearch))
        let logoutItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItems = [logoutItem, searchItem]
    }
    
    @objc private func handleLogout() { viewModel.logout() }
    @objc private func handleSearch() {
        let vc = SearchController(viewModel: SearchViewModel(useCase: SearchManager()))
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeController: TableConfigure, CollectionConfigure {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let isSelected = (indexPath.item == selectedCategoryIndex)
        cell.titleLabel.text = categories[indexPath.item]
        cell.contentView.backgroundColor = isSelected ? .systemBlue : .systemGray6
        cell.titleLabel.textColor = isSelected ? .white : .darkGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        selectedCategoryIndex = indexPath.item
        viewModel.getNewsList(category: selectedCategory.lowercased())
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 100, height: 40)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNewsCell", for: indexPath) as! HomeNewsCell
        let article = viewModel.articles[indexPath.row]
        cell.setCell(item: article, category: selectedCategory)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = NewsDetailController(viewModel: .init(useCase: BookMarkManager()))
        controller.article = viewModel.articles[indexPath.row]
        controller.categoryName = selectedCategory
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (table.contentSize.height - 100 - scrollView.frame.size.height) {
            viewModel.fetchNextPage()
        }
    }
}

