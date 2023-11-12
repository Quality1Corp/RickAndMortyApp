//
//  LoginViewModel.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 08.10.2023.
//

import Foundation

protocol LoginViewDelegate: AnyObject {
    func getLogin() -> String
    func getPassword() -> String
}

final class LoginViewModel {
    
    static let login = "123"
    static let password = "123"
    
    unowned var delegate: LoginViewDelegate!
    private let authManager = AuthManager.shared
    
    func saveDataKeychain() {
        authManager.save(
            username: delegate.getLogin(),
            password: delegate.getPassword()
        )
    }
}
