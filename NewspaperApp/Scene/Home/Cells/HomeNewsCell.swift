//
//  HomeNewsCell.swift
//  NewspaperApp
//
//  Created by user on 15.03.26.
//

import UIKit
import Kingfisher

class HomeNewsCell: UITableViewCell {
    
    private let newsImageVieW: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .systemGray6
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    private let titleLabel: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 2
        l.font = .systemFont(ofSize: 16, weight: .bold)
        return l
    }()
    
    private let categoryLabel: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 10, weight: .bold)
        l.textColor = .systemBlue
        l.backgroundColor = .systemGray6
        l.layer.cornerRadius = 8
        l.layer.masksToBounds = true
        return l
    }()
    
    private let timeLabel: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .darkGray
        return l
    }()
    
    private let descriptionLabel: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = .darkGray
        l.numberOfLines = 3
        return l
    }()
    
    private let infoStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        return stack
    }()
    
     lazy var bookmarkButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        b.tintColor = .systemBlue
        b.backgroundColor = .white.withAlphaComponent(0.8)
        b.layer.cornerRadius = 15
        b.translatesAutoresizingMaskIntoConstraints = false
        b.isHidden = true
        b.isUserInteractionEnabled = true
        return b
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    func configureUI() {
        contentView.addSubview(newsImageVieW)
        contentView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(categoryLabel)
        infoStackView.addArrangedSubview(timeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bookmarkButton)
        contentView.bringSubviewToFront(bookmarkButton)
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            newsImageVieW.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            newsImageVieW.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsImageVieW.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            newsImageVieW.heightAnchor.constraint(equalToConstant: 200),
            
            bookmarkButton.topAnchor.constraint(equalTo: newsImageVieW.topAnchor, constant: 8),
            bookmarkButton.trailingAnchor.constraint(equalTo: newsImageVieW.trailingAnchor, constant: -8),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 30),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 30),
            
            categoryLabel.heightAnchor.constraint(equalToConstant: 24),
            
            infoStackView.topAnchor.constraint(equalTo: newsImageVieW.bottomAnchor, constant: 12),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    
    func setCell(item: Article, category: String) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        timeLabel.text = item.publishedAt?.setRelativeTime()
        categoryLabel.text = category.uppercased()
        
        if let urlString = item.urlToImage, let url = URL(string: urlString) {
            newsImageVieW.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
        
        if category == "Saved" {
                bookmarkButton.isHidden = false
                bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            } else {
                bookmarkButton.isHidden = true
                bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
    }
}
