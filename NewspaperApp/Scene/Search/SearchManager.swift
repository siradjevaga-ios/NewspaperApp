//
//  SearchManager.swift
//  NewspaperApp
//
//  Created by user on 31.03.26.
//

import Foundation

class SearchManager: SearchUseCase {
    func getSearch(query: String, completion: @escaping (NewsResponse?, String?) -> Void) {
        let urlString = "https://newsapi.org/v2/everything?q=\(query)&apiKey=0520b54b340441f28174ba6afe5742ef"
        completion(nil, nil)
//        NetworkManager.shared
    }
}
