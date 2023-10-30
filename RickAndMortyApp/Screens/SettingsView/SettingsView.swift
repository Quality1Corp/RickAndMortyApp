//
//  SettingsView.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 14.10.2023.
//

import UIKit

final class SettingsView: UIViewController {
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5955260396, green: 0.2014748454, blue: 0.1873997748, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .heavy)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Password", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .heavy)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.6748661399, green: 0.8078844547, blue: 0.6908774376, alpha: 1)
        
        view.addSubview(logoutButton)
        view.addSubview(changePasswordButton)
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
