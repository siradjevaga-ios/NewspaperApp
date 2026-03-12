//
//  HomeController.swift
//  NewspaperApp
//
//  Created by user on 03.03.26.
//

import UIKit

class HomeController: UIViewController {
    let testURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=0520b54b340441f28174ba6afe5742ef"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetch(url: testURL) { (result: Result<NewsResponse, Error>) in
            switch result {
            case .success(let news):
                print("Xeberlerin sayi: \(news.articles?.count ?? 0)")
                if let firstArticle = news.articles?.first?.title {
                    print("Ilk xeber basliqi: \(firstArticle)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
