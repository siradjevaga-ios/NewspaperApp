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
    
    private var recentSearches = ["Artificial intelegence in 2026", "Trump", "World Cup 2026"]
    private var topics = ["#GlobalWarming", "#AI_Revolution", "#WorldCup", "#Crypto", "#HealthTech", "#SpaceX"]
    
    private let trendingHeaderLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Trending Topics"
        l.font = .systemFont(ofSize: 18, weight: .bold)
        return l
    }()
    
    private lazy var trendingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
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
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            
            table.heightAnchor.constraint(equalToConstant: 200),
            trendingCollectionView.heightAnchor.constraint(equalToConstant: 120),
            
            exploreIcon.heightAnchor.constraint(equalToConstant: 148),
            exploreIcon.widthAnchor.constraint(equalToConstant: 148)
        ])
    }
}

extension SearchController: TableConfigure, CollectionConfigure  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        cell.textLabel?.text = recentSearches[indexPath.row]
        cell.imageView?.image = UIImage(systemName: "clock.arrow.circlepath")
        cell.imageView?.tintColor = .gray
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recentSearches.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
        cell.titleLabel.text = topics[indexPath.row]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let text = topics[indexPath.row]
//        let font = UIFont.systemFont(ofSize: 14, weight: .medium)
//        let textWidth = text.size(withAttributes: [.font: font]).width
//        let totalWidth = textWidth + 60
//        return CGSize(width: totalWidth, height: 36)
//    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = topics[indexPath.item]
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width
        
        return CGSize(width: width + 40, height: 32)
    }
}
