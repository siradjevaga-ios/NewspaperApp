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
    
    private let titleLabel: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 22, weight: .bold)
        l.numberOfLines = 0
        return l
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
        super.configureUI()
        view.addSubview(newsImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(readMoreButton)
        configureConstraints()
    }
    override func configureConstraints() {
        super.configureConstraints()
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newsImageView.heightAnchor.constraint(equalToConstant: 240),
            
            titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
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
        
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            newsImageView.kf.setImage(with: url)
        }
    }
}
