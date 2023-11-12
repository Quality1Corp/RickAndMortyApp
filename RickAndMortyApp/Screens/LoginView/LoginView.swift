//
//  LoginView.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 07.10.2023.
//

import UIKit

final class LoginView: UIViewController, LoginViewDelegate {
    
    // MARK: - Private properties
    private let viewModel = LoginViewModel()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var loginTextField: UITextField = {
        let textField = ShadowTextField(
            placeholder: "Enter your login",
            isSecure: nil
        )
        return textField.createTextField()
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = ShadowTextField(
            placeholder: "Enter your password",
            isSecure: true
        )
        return textField.createTextField()
    }()
    
    private lazy var loginButton: UIButton = {
        let button = FilledButtonFactory(
            title: "Login",
            color: #colorLiteral(red: 0, green: 0.1532281041, blue: 0.6397063136, alpha: 1),
            buttonPressed: #selector(loginButtonPressed),
            buttonReleased: #selector(loginButtonReleased)
        )
        return button.createButton()
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Public methods
    func getLogin() -> String {
        loginTextField.text ?? ""
    }
    
    func getPassword() -> String {
        passwordTextField.text ?? ""
    }
    
    func hideGesture() -> UIGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(
            dismissKeyboard
        ))
        return tapGesture
    }
    
    @objc func loginButtonPressed() {
        loginButton.backgroundColor = #colorLiteral(red: 0, green: 0.1532281041, blue: 0.6397063136, alpha: 1)
        if loginTextField.text == LoginViewModel.login, passwordTextField.text == LoginViewModel.password {
            viewModel.saveDataKeychain()
            
            let tabBarVC = TabBarController()
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true)
        }
    }
    
    @objc func loginButtonReleased() {
        loginButton.backgroundColor = #colorLiteral(red: 0, green: 0.2328981161, blue: 0.7651376128, alpha: 0.5)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Private methods
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.6748661399, green: 0.8078844547, blue: 0.6908774376, alpha: 1)
        viewModel.delegate = self
        
        setupSubviews(
            logoImageView,
            loginTextField,
            passwordTextField,
            loginButton
        )
        
        view.addGestureRecognizer(hideGesture())
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
