//
//  BookmarkUseCase.swift
//  NewspaperApp
//
//  Created by user on 13.03.26.
//

import Foundation

protocol BookmarkUseCase {
    func getBookmarks(completion: @escaping([Article]?, Error?) -> Void)
    func addToBookmarks(article: Article, completion: @escaping(Error?) -> Void)
    func removeFromBookmarks(articleID: String, completion: @escaping(Error?) -> Void)
    func isBookmarked(articleID: String, completion: @escaping(Bool) -> Void)
}
