//
//  LoginController.swift
//  NewspaperApp
//
//  Created by user on 22.03.26.
//

import UIKit

class LoginController: BaseController {
    
    private let emailTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        tf.placeholder = "Email Address"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        return tf
    }()
    private lazy var passwordTextField: UITextField = {
       let p = UITextField()
        p.borderStyle = .roundedRect
        p.autocorrectionType = .no
        p.placeholder = "password"
        p.translatesAutoresizingMaskIntoConstraints = false
        p.isSecureTextEntry = true
        p.autocapitalizationType = .none
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .systemGray
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        p.rightView = button
        p.rightViewMode = .always
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return p
    }()
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private let orLabel: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "OR"
        l.font = .systemFont(ofSize: 14)
        l.textAlignment = .center
        l.tintColor = .systemGray
        return l
    }()
    
    private let orSeparatorStack: UIStackView = {
       let stack = UIStackView()
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
