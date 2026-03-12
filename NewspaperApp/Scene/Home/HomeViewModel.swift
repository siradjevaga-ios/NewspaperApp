//
//  HomeViewModel.swift
//  NewspaperApp
//
//  Created by user on 03.03.26.
//

import Foundation

class HomeViewModel {
    var articles = [Article]()

    
    func getMovies(completion: @escaping ((String?) -> Void) ) {
        let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=0520b54b340441f28174ba6afe5742ef"
        NetworkManager.shared.fetch(url: url) { [weak self] (result: Result<NewsResponse, Error>) in
            switch result {
            case .success(let news):
                self?.articles = news.articles ?? []
                completion(nil)
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
}
