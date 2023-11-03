//
//  AuthManager.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 09.10.2023.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    func save(username: String, password: String) {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: password.data(using: .utf8) as Any
        ]
        
        let status = SecItemAdd(attributes as CFDictionary, nil)
        guard status == errSecSuccess else {
            print("Не удалось сохранить данные в Keychain")
            return
        }
        print("Данные успешно сохранены в Keychain")
    }
    
    func update(password: String) {
        let passwordData = password.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: passwordData
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status == errSecSuccess else {
            print("Не удалось изменит пароль в Keychain")
            return
        }
        print("Пароль успешно изменен!")
    }
    
    func delete() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess else {
            print("Не удалось удалить данные из Keychain")
            return
        }
        print("Данные успешно удалены из Keychain")
    }
}
