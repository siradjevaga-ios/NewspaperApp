//
//  BookmarkController.swift
//  NewspaperApp
//
//  Created by user on 03.03.26.
//

import UIKit

class BookmarkController: BaseController {
    
    private lazy var emptyView : UIView = {
        let ev = UIView(frame: table.bounds)
        return ev
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let icon: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 60, weight: .bold, scale: .large)
        let image = UIImage(systemName: "bookmark.slash", withConfiguration: config)
        
        let icon = UIImageView(image: image)
        icon.tintColor = .systemGray3
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "Add Bookmarks"
        l.textColor = .systemGray
        l.font = .systemFont(ofSize: 24, weight: .bold)
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
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
    
    private let viewModel: BookmarkViewModel
    
    init(viewModel: BookmarkViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Saved News"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func configureUI() {
        view.addSubview(table)
        emptyView.frame = view.bounds
        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(label)
        emptyView.addSubview(stack)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stack.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 40),
            stack.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -40),
            
            icon.heightAnchor.constraint(equalToConstant: 100),
            icon.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func fetchData() {
        viewModel.fetchBookmarks { [weak self] errorMessage in
            if let errorMessage {
                print(errorMessage)
                return
            }
            DispatchQueue.main.async {
                self?.table.reloadData()
                self?.updateEmptyState()
            }
        }
    }
    
    private func updateEmptyState() {
        if viewModel.bookmarks.isEmpty {
            table.backgroundView = emptyView
        } else {
            table.backgroundView = nil
        }
    }
}
extension BookmarkController: TableConfigure {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNewsCell", for: indexPath) as! HomeNewsCell
        let article = viewModel.bookmarks[indexPath.row]
        cell.setCell(item: article, category: "Saved")
        cell.bookmarkButton.tag = indexPath.row
        cell.bookmarkButton.addTarget(self, action: #selector(handleCellBookmarkTap(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc private func handleCellBookmarkTap(_ sender: UIButton) {
        let index = sender.tag
        guard index < viewModel.bookmarks.count else { return }
        let article = viewModel.bookmarks[index]
        let currentImage = sender.image(for: .normal)
        let isCurrentlyFilled = currentImage == UIImage(systemName: "bookmark.fill")
        let newIcon = isCurrentlyFilled ? "bookmark" : "bookmark.fill"
        sender.setImage(UIImage(systemName: newIcon), for: .normal)
        viewModel.toggleBookmark(article: article) { [weak self] error in
            if let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    sender.setImage(currentImage, for: .normal)
                }
                return
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = NewsDetailController(viewModel: .init(useCase: BookMarkManager()))
        controller.hidesBottomBarWhenPushed = true
        controller.article = viewModel.bookmarks[indexPath.row]
        controller.categoryName = "Saved"
        navigationController?.pushViewController(controller, animated: true)
    }
}
