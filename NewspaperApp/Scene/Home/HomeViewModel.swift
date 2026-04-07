

import Foundation
import FirebaseAuth

final class HomeViewModel {
    var articles = [Article]()
    private(set) var useCase: HomeUseCase
    
    private var currentPage = 1
    private var isPaginating = false
    private var currentCategory = "general"
    
    var error: ((String) -> Void)?
    var success: (() -> Void)?
    var onLogoutSuccess: (() -> Void)?
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    func getNewsList(category: String = "general") {
        self.currentPage = 1
        self.currentCategory = category
        self.isPaginating = false
        
        useCase.getNews(category: category, page: currentPage) { [weak self] data, errorMessage in
            if let errorMessage = errorMessage {
                self?.error?(errorMessage)
            } else if let data = data {
                self?.articles = data.articles ?? []
                self?.success?()
            }
        }
    }
    
    func fetchNextPage() {
        guard !isPaginating else { return }
        
        isPaginating = true
        currentPage += 1
        
        useCase.getNews(category: currentCategory, page: currentPage) { [weak self] data, errorMessage in
            guard let self = self else { return }
            self.isPaginating = false
            
            if let newArticles = data?.articles, !newArticles.isEmpty {
                self.articles.append(contentsOf: newArticles)
                self.success?()
            } else {
                print("Daha xeber yoxdur")
            }
        }
    }
    
    func logout() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            onLogoutSuccess?()
        } catch {
            self.error?(error.localizedDescription)
        }
    }
}
