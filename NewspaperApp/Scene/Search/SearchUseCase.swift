//
//  SearchUseCase.swift
//  NewspaperApp
//
//  Created by user on 30.03.26.
//

import Foundation

protocol SearchUseCase {
    func getSearch(query: String, completion: @escaping (NewsResponse?, String?) -> Void )
}
