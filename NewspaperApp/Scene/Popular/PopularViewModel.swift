//
//  SearchViewModel.swift
//  NewspaperApp
//
//  Created by user on 03.03.26.
//

import Foundation

class PopularViewModel {
    var articles = [Article]()
    
    private let useCase: PopularUseCase
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?

    init(useCase: PopularUseCase) {
        self.useCase = useCase
    }
    
    func getPopularNews() {
        useCase.getPopularNews { [weak self] data, errorMessage in
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
