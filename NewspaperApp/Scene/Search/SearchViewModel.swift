//
//  SearchViewModel.swift
//  NewspaperApp
//
//  Created by user on 29.03.26.
//

import Foundation

final class SearchViewModel {
    private let useCase: SearchUseCase
    
    init (useCase: SearchUseCase) {
        self.useCase = useCase
    }
    private var recentSearches = ["Artificial intelegence in 2026", "Trump", "World Cup 2026"]
    private var topics = ["#GlobalWarming", "#AI_Revolution", "#WorldCup", "#Crypto", "#HealthTech", "#SpaceX"]
    
    func numberOfTopics() -> Int {
        return topics.count
    }
    
    func addTopics(at index: Int) -> String {
         return topics[index]
    }
    
    func numberOfSearches() -> Int {
        return recentSearches.count
    }
    
    func addRecentSearches(at index: Int) -> String {
        return recentSearches[index]
    }
    
    func removeRecentSearch(at index: Int) {
        recentSearches.remove(at: index)
    }
}

