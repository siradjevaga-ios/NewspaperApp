//
//  HomeDetailController.swift
//  NewspaperApp
//
//  Created by user on 17.03.26.
//

import UIKit
import Kingfisher

class HomeDetailController: BaseController {
    var article: Article?
    
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
            label.backgroundColor = UIColor.systemBlue/*.withAlphaComponent(0.1)*/
            label.layer.cornerRadius = 4
            label.clipsToBounds = true
            label.textAlignment = .center
            label.text = "TECHNOLOGY"
            return label
        }()
    
    private let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 24, weight: .bold)
            label.numberOfLines = 0
            return label
        }()
    
    private let authorLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 16, weight: .semibold)
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
        dl.textColor = .secondaryLabel
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
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureData()
    }
    
    override func configureUI() {
        title = "News Detail"
        view.addSubview(newsImageView)
        view.addSubview(categoryLabel)
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(sourceAndDateLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(readMoreButton)
    }
    override func configureConstraints() {
        super.configureConstraints()
        NSLayoutConstraint.activate([
            
            newsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newsImageView.heightAnchor.constraint(equalToConstant: 240),
            
            categoryLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.heightAnchor.constraint(equalToConstant: 24),
            categoryLabel.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            sourceAndDateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            sourceAndDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: sourceAndDateLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            readMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            readMoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            readMoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            readMoreButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func configureData() {
        guard let article = article else { return }
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        authorLabel.text = article.author ?? "Unknown Author"
        
        let source = article.source?.name ?? "Source"
        let date = article.publishedAt?.setRelativeTime() ?? ""
        sourceAndDateLabel.text = "\(source)  •  \(date)"
        
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            newsImageView.kf.setImage(with: url)
        }
    }
}
