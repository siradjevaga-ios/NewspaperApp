//
//  AuthUseCase.swift
//  NewspaperApp
//
//  Created by user on 03.04.26.
//

import Foundation

protocol AuthUseCase {
    func registerUser(email: String, password: String, completion: @escaping (Error?) -> Void)
    func loginUser(email: String, password: String, completion: @escaping (Error?) -> Void)
}
