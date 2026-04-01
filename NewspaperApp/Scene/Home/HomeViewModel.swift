//
//  HomeViewModel.swift
//  NewspaperApp
//
//  Created by user on 03.03.26.
//

import Foundation

final class HomeViewModel {
    var articles = [Article]()
    
    private(set) var useCase: HomeUseCase
    
    var error: ((String) -> Void)?
    var success: (() -> Void)?
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    func getNewsList(category: String = "general") {
        useCase.getNews(category: category) { [weak self] data, errorMessage in
            if let errorMessage {
                self?.error?(errorMessage)
            }
            else if let data {
                self?.articles = data.articles ?? []
                self?.success?()
            }
        }
    }
}
