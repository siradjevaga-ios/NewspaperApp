//
//  HomeDetailController.swift
//  NewspaperApp
//
//  Created by user on 17.03.26.
//

import UIKit
import Kingfisher

class HomeDetailController: UIViewController {
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
}
