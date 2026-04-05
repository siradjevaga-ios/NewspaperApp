//
//  BookmarViewModel.swift
//  NewspaperApp
//
//  Created by user on 03.03.26.
//

import Foundation

class BookmarViewModel {
    private let useCase: BookmarkUseCase
    var bookmarks = [Article]()
    
    init(useCase: BookmarkUseCase) {
        self.useCase = useCase
    }
    
    func fethBookmarks(completion: @escaping(String?) -> Void) {
        useCase.getBookmarks { [weak self]  downloadedArticles, error in
            if let error {
                completion(error.localizedDescription)
                return
            }
            if let downloadedArticles {
                self?.bookmarks = downloadedArticles
                completion(nil)
            }
        }
    }
    
    func toggleBookmark(article: Article, completion: @escaping (Error?) -> Void) {
        let articleID = article.title ?? ""
        
    }
}
