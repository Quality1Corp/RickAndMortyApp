//
//  SettingsView.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 14.10.2023.
//

import UIKit

final class SettingsView: UIViewController {
    
    // MARK: - Private properties
    private let viewModel = SettingsViewModel()
    
    private lazy var logoutButton: UIButton = {
        let button = FilledButtonFactory(
            title: "Logout",
            color: #colorLiteral(red: 0.5955260396, green: 0.2014748454, blue: 0.1873997748, alpha: 1),
            buttonPressed: #selector(logoutButtonPressed),
            buttonReleased: #selector(logoutButtonReleased)
        )
        return button.createButton()
    }()
    
    private lazy var changePasswordButton: UIButton = {
        let button = FilledButtonFactory(
            title: "Change Password",
            color: .blue,
            buttonPressed: #selector(changePasswordButtonPressed),
            buttonReleased: #selector(changePasswordButtonReleased)
        )
        return button.createButton()
    }()
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    // MARK: - Public methods
    @objc func logoutButtonPressed() {
        logoutButton.backgroundColor = #colorLiteral(red: 0.5955260396, green: 0.2014748454, blue: 0.1873997748, alpha: 1)
        
        if let loginView = presentingViewController as? LoginView {
            loginView.loginTextField.text = ""
            loginView.passwordTextField.text = ""
            loginView.dismiss(animated: true)
        }
        viewModel.deleteDataKeychain()
    }
    
    @objc func logoutButtonReleased() {
        logoutButton.backgroundColor = #colorLiteral(red: 0.5955260396, green: 0.2014748454, blue: 0.1873997748, alpha: 0.301660803)
    }
    
    @objc func changePasswordButtonPressed() {
        changePasswordButton.backgroundColor = .blue
        
        showAlert()
    }
    
    @objc func changePasswordButtonReleased() {
        changePasswordButton.backgroundColor = UIColor(.blue.opacity(0.8))
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.6748661399, green: 0.8078844547, blue: 0.6908774376, alpha: 1)
        setupSubviews(logoutButton, changePasswordButton)
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            logoutButton.heightAnchor.constraint(equalToConstant: 60),
            
            changePasswordButton.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 30),
            changePasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            changePasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

// MARK: - Extension SettingsView
extension SettingsView {
    private func showAlert() {
        let alertController = UIAlertController(
            title: "Смена пароля",
            message: "Введите ваш новый пароль!",
            preferredStyle: .alert
        )
        alertController.addTextField { textField in
            textField.placeholder = "Например: 1234"
            textField.isSecureTextEntry = true
        }
        
        let saveButton = UIAlertAction(title: "Сохранить", style: .cancel) { [unowned self] action in
            guard let textField = alertController.textFields?.first, let password = textField.text else {
                return
            }
            self.viewModel.authManager.update(newPassword: password)
        }
        let cancelButton = UIAlertAction(title: "Отмена", style: .destructive)
        
        alertController.addAction(saveButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
}
