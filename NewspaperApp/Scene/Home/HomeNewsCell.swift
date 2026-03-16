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
        l.font = .systemFont(ofSize: 12, weight: .bold)
        l.textColor = .systemBlue
        return l
    }()
    
    private let timeLabel: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .lightGray
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
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            newsImageVieW.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            newsImageVieW.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsImageVieW.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            newsImageVieW.heightAnchor.constraint(equalToConstant: 200),
            
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
        timeLabel.text = item.publishedAt
        categoryLabel.text = category.uppercased()
        
        if let urlString = item.urlToImage, let url = URL(string: urlString) {
            newsImageVieW.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
    }
}
