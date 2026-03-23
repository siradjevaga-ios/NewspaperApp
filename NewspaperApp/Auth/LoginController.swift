//
//  LoginController.swift
//  NewspaperApp
//
//  Created by user on 22.03.26.
//

import UIKit

class LoginController: BaseController {
    
    private lazy var mainStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(continueButton)
        stack.addArrangedSubview(orSeparatorStack)
        stack.addArrangedSubview(googleButton)
        stack.addArrangedSubview(iosButton)
        stack.addArrangedSubview(facebookButton)
        stack.setCustomSpacing(24, after: orSeparatorStack)
        return stack
    }()
    
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
    
    private let continueButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Continue", for: .normal)
        b.layer.cornerRadius = 4
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .black
        b.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let orLabel: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "OR"
        l.font = .systemFont(ofSize: 14)
        l.textAlignment = .center
        l.tintColor = .systemGray
        return l
    }()
    
    private lazy var orSeparatorStack: UIStackView = {
       let stack = UIStackView()
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        
        func createLine() -> UIView {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            view.backgroundColor = .systemGray4
            return view
        }
        
        let leftLine = createLine()
        let rightLine = createLine()
        
        stack.addArrangedSubview(leftLine)
        stack.addArrangedSubview(orLabel)
        stack.addArrangedSubview(rightLine)
        
        leftLine.widthAnchor.constraint(equalTo: rightLine.widthAnchor).isActive = true
        
        return stack
    }()
   
    private func createSocialButton(title: String, image: UIImage?) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = image?.withRenderingMode(.alwaysOriginal)
        config.title = title
        config.background.strokeWidth = 1
        config.background.strokeColor = .systemGray4
        config.imagePadding = 12
        config.imagePlacement = .leading
        config.baseForegroundColor = .label
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }
    
    private lazy var googleButton = createSocialButton(title: "Continue with Google", image: UIImage(named: "google_logo"))
    private lazy var iosButton = createSocialButton(title: "Continue with IOS", image: UIImage(systemName: "apple.logo"))
    private lazy var facebookButton = createSocialButton(title: "Continue with Facebook", image: UIImage(named: "facebook_logo"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
