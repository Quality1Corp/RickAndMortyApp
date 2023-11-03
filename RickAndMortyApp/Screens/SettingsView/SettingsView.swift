//
//  SettingsView.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 14.10.2023.
//

import UIKit

final class SettingsView: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
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
    
    @objc func logoutButtonPressed() {
        logoutButton.backgroundColor = #colorLiteral(red: 0.5955260396, green: 0.2014748454, blue: 0.1873997748, alpha: 1)
        
        viewModel.authManager.delete()
        presentingViewController?.dismiss(animated: true)
    }
    
    @objc func logoutButtonReleased() {
        logoutButton.backgroundColor = #colorLiteral(red: 0.5955260396, green: 0.2014748454, blue: 0.1873997748, alpha: 0.301660803)
    }
    
    @objc func changePasswordButtonPressed() {
        changePasswordButton.backgroundColor = .blue
        
        let alertController = UIAlertController(
            title: "Изменение пароля",
            message: "Введите ваш новый пароль",
            preferredStyle: .alert
        )
        alertController.addTextField { (textField) in
            textField.placeholder = "Новый пароль"
            textField.isSecureTextEntry = true
        }
        
        let okAction = UIAlertAction(title: "Ок", style: .default) { [unowned self] _ in
            if let newPassword = alertController.textFields?.first?.text {
                self.viewModel.authManager.update(password: newPassword)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func changePasswordButtonReleased() {
        changePasswordButton.backgroundColor = UIColor(.blue.opacity(0.8))
    }
}
