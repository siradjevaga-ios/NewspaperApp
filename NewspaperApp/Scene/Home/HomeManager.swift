//
//  HomeManager.swift
//  NewspaperApp
//
//  Created by user on 12.03.26.
//

import Foundation

class HomeManager: HomeUseCase {
    func getNews(completion: @escaping (NewsResponse?, String?) -> Void) {
        let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=0520b54b340441f28174ba6afe5742ef"
        NetworkManager.shared.fetch(url: url) { (result: Result<NewsResponse, Error>) in
            switch result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
