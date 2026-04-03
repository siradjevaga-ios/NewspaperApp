//
//  SearchController.swift
//  NewspaperApp
//
//  Created by user on 27.03.26.
//

import UIKit

class SearchController: BaseController {
    
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search news, topics and more"
        return search
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIStackView = {
        let cv = UIStackView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.axis = .vertical
        cv.spacing = 20
        return cv
    }()
    
    private let recentHeaderLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 18, weight: .bold)
        l.textColor = .label
        l.text = "Recent Searches"
        return l
    }()
    
    private lazy var table: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.isScrollEnabled = false
        //        t.separatorStyle = .none
        t.dataSource = self
        t.delegate = self
        t.register(UITableViewCell.self, forCellReuseIdentifier: "searchCell")
        t.showsVerticalScrollIndicator = false
        return t
    }()
    
    private let trendingHeaderLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Trending Topics"
        l.font = .systemFont(ofSize: 18, weight: .bold)
        return l
    }()
    
    private lazy var trendingCollectionView: UICollectionView = {
        let layout = LeftAlignedFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
    
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(TrendingCell.self, forCellWithReuseIdentifier: "TrendingCell")
        collection.isScrollEnabled = false
        collection.backgroundColor = .clear
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let exploreIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemGray4
        iv.image = UIImage(systemName: "globe.americas.fill")
        return iv
    }()
    
    private let exploreLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.font = .systemFont(ofSize: 20, weight: .bold)
        l.text = "Explore the World"
        return l
    }()
    
    private lazy var resultsTable: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.delegate = self
        t.dataSource = self
        t.showsVerticalScrollIndicator = false
        t.register(UITableViewCell.self, forCellReuseIdentifier: "resultCell")
        t.isHidden = true
        return t
    }()
    
    private let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func configureUI() {
        super.configureUI()
        view.addSubview(resultsTable)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(recentHeaderLabel)
        contentView.addArrangedSubview(table)
        contentView.addArrangedSubview(trendingHeaderLabel)
        contentView.addArrangedSubview(trendingCollectionView)
        contentView.addArrangedSubview(exploreIcon)
        contentView.addArrangedSubview(exploreLabel)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        NSLayoutConstraint.activate([
            resultsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 12),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            
            table.heightAnchor.constraint(equalToConstant: 200),
            trendingCollectionView.heightAnchor.constraint(equalToConstant: 120),
            
            exploreIcon.heightAnchor.constraint(equalToConstant: 148),
            exploreIcon.widthAnchor.constraint(equalToConstant: 148)
        ])
    }
    
    override func configureViewModel() {
        viewModel.success = { [weak self] in
            DispatchQueue.main.async {
                self?.resultsTable.reloadData()
            }
        }
        viewModel.error = { message in
            print(message)
        }
    }
}

extension SearchController: TableConfigure, CollectionConfigure, UISearchBarDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == resultsTable {
            return viewModel.showNumberOfResults()
        } else {
            return viewModel.numberOfSearches()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == resultsTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
//            let searchText = searchController.searchBar.text ?? ""
            let article = viewModel.showResults(at: indexPath.item)
            cell.textLabel?.text = article.title
            cell.imageView?.image = UIImage(systemName: "doc.text.fill")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
            cell.textLabel?.text = viewModel.addRecentSearches(at: indexPath.row)
            cell.imageView?.image = UIImage(systemName: "clock.arrow.circlepath")
            cell.imageView?.tintColor = .gray
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == resultsTable {
            let detailVC = HomeDetailController()
            let selectedNews = viewModel.showResults(at: indexPath.item)
            detailVC.article = selectedNews
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeRecentSearch(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfTopics()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
        cell.titleLabel.text = viewModel.addTopics(at: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = viewModel.addTopics(at: indexPath.item)
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width
        
        return CGSize(width: width + 40, height: 32)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        recentHeaderLabel.isHidden = true
        table.isHidden = true
        trendingHeaderLabel.isHidden = true
        trendingCollectionView.isHidden = true
        exploreIcon.isHidden = true
        exploreLabel.isHidden = true
        
        resultsTable.isHidden = false
        scrollView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty  else { return }
        viewModel.search(text: text)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.searchResults.removeAll()
        resultsTable.reloadData()
        table.reloadData()
        
        recentHeaderLabel.isHidden = false
        table.isHidden = false
        trendingHeaderLabel.isHidden = false
        trendingCollectionView.isHidden = false
        exploreIcon.isHidden = false
        exploreLabel.isHidden = false
        
        resultsTable.isHidden = true
        scrollView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultsTable.reloadData()
        if searchText.isEmpty {
            print("yazı yoxdur")
        }
    }
}
