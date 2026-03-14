//
//  HomeUseCase.swift
//  NewspaperApp
//
//  Created by user on 12.03.26.
//

import Foundation

protocol HomeUseCase {
    func getNews(category: String, completion: @escaping (NewsResponse?, String?) -> Void)
}
