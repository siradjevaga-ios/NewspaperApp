//
//  AuthViewModel.swift
//  NewspaperApp
//
//  Created by user on 03.04.26.
//

import Foundation

class RegisterViewModel {
    var useCase: AuthUseCase
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    init(useCase: AuthUseCase = AuthManager.shared) {
        self.useCase = useCase
    }
    
    func register(email: String?, password: String?) {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty else {
            self.error?("error")
            return
        }
        useCase.registerUser(email: email, password: password) { [weak self] firebaseError in
            if let error = firebaseError {
                self?.error?(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self?.success?()
                }
            }
        }
    }
}
