//
//  HomeDetailController.swift
//  NewspaperApp
//
//  Created by user on 17.03.26.
//

import UIKit
import Kingfisher
import SafariServices

class NewsDetailController: BaseController {
    
    private let scrollView: UIScrollView = {
       let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
//        s.showsVerticalScrollIndicator = true
        s.alwaysBounceVertical = true
        return s
    }()
    
    private let contentView: UIView = {
       let c = UIView()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private let newsImageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    private let categoryLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 12, weight: .bold)
            label.textColor = .systemBlue
            label.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            label.textAlignment = .center
            return label
        }()
    
    private let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 24, weight: .bold)
            label.numberOfLines = 0
            return label
        }()
    
    private let authorImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .center
        iv.image = UIImage(systemName: "person.fill")
        iv.tintColor = .systemGray6
        iv.backgroundColor = .systemBlue
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        return iv
    }()
    
    private let containerView: UIView = {
       let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .secondarySystemBackground
        cv.layer.cornerRadius = 12
        return cv
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let sourceAndDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let dl = UILabel()
        dl.translatesAutoresizingMaskIntoConstraints = false
        dl.font = .systemFont(ofSize: 16, weight: .regular)
        dl.numberOfLines = 0
        dl.textColor = .systemGray
        return dl
    }()
    
    private let readMoreButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Read Full Article", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .systemBlue
        b.layer.cornerRadius = 12
        b.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        b.addTarget(self, action: #selector(openFullArticle), for: .touchUpInside)
        return b
    }()
    
    private lazy var bookmarkButton: UIBarButtonItem = {
        let bookmark = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .plain,
            target: self,
            action: #selector(bookmarkTapped))
        bookmark.tintColor = .systemBlue
        return bookmark
    }()
    
    var article: Article?
    var categoryName: String?
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
        view.backgroundColor = .systemBackground
        configureData()
        checkBookmarkStatus()
    }
    
    private func checkBookmarkStatus() {
        guard let articleID = article?.title else { return }
            viewModel.checkBookmarkStatus(articleID: articleID) { [weak self] isBookmarked in
            let imageName = isBookmarked ? "bookmark.fill" : "bookmark"
            self?.bookmarkButton.image = UIImage(systemName: imageName)
        }
    }
    
    @objc func openFullArticle() {
        guard let urlString = article?.url,
              let url = URL(string: urlString)  else {
            print("link tapilmadi")
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    @objc
    private func bookmarkTapped() {
        guard let article = article else { return }
        bookmarkButton.isEnabled = false
        viewModel.toggleBookmark(article: article) { [weak self] error in
            DispatchQueue.main.async {
                self?.bookmarkButton.isEnabled = true
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                let isCurrentlyFilled = self?.bookmarkButton.image == UIImage(systemName: "bookmark.fill")
                self?.bookmarkButton.image = UIImage(systemName: isCurrentlyFilled ? "bookmark" : "bookmark.fill")
            }
        }
    }
    
    override func configureUI() {
        title = "News Detail"
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(containerView)
        contentView.addSubview(descriptionLabel)
       
        containerView.addSubview(authorImage)
        containerView.addSubview(authorLabel)
        containerView.addSubview(sourceAndDateLabel)
        
        view.addSubview(readMoreButton)
        navigationItem.rightBarButtonItem = bookmarkButton
        
    }
    override func configureConstraints() {
        super.configureConstraints()
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            newsImageView.heightAnchor.constraint(equalToConstant: 240),
            
            categoryLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoryLabel.heightAnchor.constraint(equalToConstant: 24),
            categoryLabel.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            authorImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            authorImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            authorImage.widthAnchor.constraint(equalToConstant: 40),
            authorImage.heightAnchor.constraint(equalToConstant: 40),

            authorLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 12),
            authorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            
            sourceAndDateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            sourceAndDateLabel.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 12),
            sourceAndDateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            descriptionLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -120),
            
            readMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            readMoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            readMoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            readMoreButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    func configureData() {
        guard let article = article else { return }
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        authorLabel.text = article.author ?? "Unknown Author"
        categoryLabel.text = categoryName?.uppercased() ?? "GENERAL"
        
        let source = article.source?.name ?? "Source"
        let date = article.publishedAt?.setRelativeTime() ?? ""
        sourceAndDateLabel.text = "\(source)  •  \(date)"
        
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            newsImageView.kf.setImage(with: url)
        }
    }
}
