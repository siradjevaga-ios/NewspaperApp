//
//  AuthManager.swift
//  NewspaperApp
//
//  Created by user on 02.04.26.
//

import Foundation
import FirebaseAuth

class AuthManager: AuthUseCase {
    static let shared = AuthManager()
    private init() {}
    
    func registerUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            completion(error)
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion(error)
        }
    }
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
