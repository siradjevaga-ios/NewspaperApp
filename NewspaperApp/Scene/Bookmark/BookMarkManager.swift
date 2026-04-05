//
//  BookMarkManager.swift
//  NewspaperApp
//
//  Created by user on 13.03.26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class BookMarkManager: BookmarkUseCase {
    private let db = Firestore.firestore()
    private let collectionName = "bookmarks"
    private var userID: String? { Auth.auth().currentUser?.uid }
    
    func addToBookmarks(article: Article, completion: @escaping (Error?) -> Void) {
        guard let uid = userID else { return }
        let docID = article.title ?? "Unknown Title"
        db.collection(collectionName).document(uid).collection("user_bookmarks").document(docID).setData([
            "title": article.title ?? "",
            "description": article.description ?? "",
            "urlToImage": article.urlToImage ?? "",
            "url": article.url ?? "",
            "publishedAt": article.publishedAt ?? ""
        ]) { error in
            completion(error)
        }
    }
    
    func removeFromBookmarks(articleID: String, completion: @escaping (Error?) -> Void) {
        guard let uid = userID else { return }
        db.collection(collectionName).document(uid).collection("user_bookmarks").document(articleID).delete { error in
            completion(error)
        }
    }
    func isBookmarked(articleID: String, completion: @escaping (Bool) -> Void) {
        guard let uid = userID else {
            completion(false)
            return
        }
        db.collection(collectionName).document(uid).collection("user_bookmarks").document(articleID).getDocument { (document, error) in
            if let document = document, document.exists {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func getBookmarks(completion: @escaping([Article]?, Error?) -> Void) {
        guard let uid = userID else {
            completion([], nil)
            return
        }
        db.collection(collectionName).document(uid).collection("user_bookmarks").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            let articles = querySnapshot?.documents.compactMap { document -> Article? in
                let data = document.data()
                return Article(
                    source: nil,
                    author: nil,
                    title: data["title"] as? String ?? "",
                    description: data["description"] as? String,
                    url: data["url"] as? String,
                    urlToImage: data["urlToImage"] as? String,
                    publishedAt: data["publishedAt"] as? String,
                    content: nil
                )
            }
            completion(articles, nil)
        }
    }
}

