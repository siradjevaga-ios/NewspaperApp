//
//  NetworkManager.swift
//  NewspaperApp
//
//  Created by user on 12.03.26.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetch<T: Codable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
}
