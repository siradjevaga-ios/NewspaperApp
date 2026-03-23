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
        
        stack.addArrangedSubview(appLogoLabel)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(continueButton)
        stack.addArrangedSubview(orSeparatorStack)
        stack.addArrangedSubview(googleButton)
        stack.addArrangedSubview(iosButton)
        stack.addArrangedSubview(facebookButton)
        stack.addArrangedSubview(signUpButton)
        
        stack.setCustomSpacing(32, after: appLogoLabel)
        stack.setCustomSpacing(24, after: orSeparatorStack)
        return stack
    }()
    
    private let appLogoLabel: UILabel = {
       let l = UILabel()
        l.text = "THE NEWSPAPER"
        l.font = UIFont(name: "Georgia-BoldItalic", size: 24)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let titleLabel: UILabel = {
       let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.text = "Log In or Create an account"
        t.font = .systemFont(ofSize: 28, weight: .bold)
        t.numberOfLines = 0
        return t
    }()
    
    private let emailTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        tf.placeholder = "Email address"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        return tf
    }()
    private lazy var passwordTextField: UITextField = {
       let p = UITextField()
        p.borderStyle = .roundedRect
        p.autocorrectionType = .no
        p.placeholder = "Password"
        p.translatesAutoresizingMaskIntoConstraints = false
        p.isSecureTextEntry = true
        p.autocapitalizationType = .none
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .label
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
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
        b.heightAnchor.constraint(equalToConstant: 44).isActive = true
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let orLabel: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "OR"
        l.font = .systemFont(ofSize: 12)
        l.textAlignment = .center
        l.tintColor = .systemGray
        return l
    }()
    
    private lazy var orSeparatorStack: UIStackView = {
       let stack = UIStackView()
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        
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

        if let originalImage = image {
            let size = CGSize(width: 24, height: 24)
            let renderer = UIGraphicsImageRenderer(size: size)
            let scaledImage = renderer.image { _ in
                originalImage.draw(in: CGRect(origin: .zero, size: size))
            }
            config.image = scaledImage.withRenderingMode(.alwaysOriginal)
        }
        
        config.title = title
        config.imagePadding = 12
        config.imagePlacement = .leading
        config.baseForegroundColor = .label
        config.background.strokeWidth = 1
        config.background.strokeColor = .systemGray4
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.contentHorizontalAlignment = .center
        
        return button
    }
    
    private lazy var googleButton = createSocialButton(title: "Continue with Google", image: UIImage(named: "google_logo"))
    private lazy var iosButton = createSocialButton(title: "Continue with IOS", image: UIImage(systemName: "apple.logo"))
    private lazy var facebookButton = createSocialButton(title: "Continue with Facebook", image: UIImage(named: "facebook_logo"))
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        let title = NSMutableAttributedString(
            string: "Don't have an account?",
            attributes: [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 14)]
        )
        
        let signUpPart = NSAttributedString(
            string: " Sign Up",
            attributes: [.foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 14)]
        )
        title.append(signUpPart)
        button.setAttributedTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
        view.addSubview(mainStackView)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
