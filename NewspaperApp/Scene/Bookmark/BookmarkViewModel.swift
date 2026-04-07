//
//  BookmarViewModel.swift
//  NewspaperApp
//
//  Created by user on 03.03.26.
//

import Foundation

class BookmarkViewModel {
    private let useCase: BookmarkUseCase
    var bookmarks = [Article]()
    
    init(useCase: BookmarkUseCase) {
        self.useCase = useCase
    }
    
    func fetchBookmarks(completion: @escaping(String?) -> Void) {
        self.bookmarks.removeAll()
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
        useCase.isBookmarked(articleID: articleID) { [weak self] exists in
            if exists {
                self?.useCase.removeFromBookmarks(articleID: articleID) { error in
                    if error == nil {
                        self?.bookmarks.removeAll(where: { $0.title == article.title })
                    }
                    completion(error)
                }
            } else {
                self?.useCase.addToBookmarks(article: article, completion: completion)
            }
        }
    }
    
    func checkBookmarkStatus(articleID: String, completion: @escaping (Bool) -> Void) {
        useCase.isBookmarked(articleID: articleID, completion: completion)
    }
}

