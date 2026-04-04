//
//  LoginViewModel.swift
//  NewspaperApp
//
//  Created by user on 03.04.26.
//

import Foundation

class LoginViewModel {
    
    private let useCase: AuthUseCase
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    init(useCase: AuthUseCase = AuthManager.shared) {
        self.useCase = useCase
    }
    func login(email: String?, pass: String?) {
        guard let email = email, !email.isEmpty,
              let pass = pass, !pass.isEmpty
        else {
            self.error?("error")
            return
        }
        useCase.loginUser(email: email, password: pass) { [weak self] firebaseError in
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
