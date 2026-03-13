//
//  PopularUseCase.swift
//  NewspaperApp
//
//  Created by user on 13.03.26.
//

import Foundation

protocol PopularUseCase {
    func getPopularNews(completion: @escaping(NewsResponse?, String?) -> Void)
}
