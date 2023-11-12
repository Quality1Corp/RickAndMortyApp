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
    
    /// Сохранение значений логина и пароля в keychain
    func save(username: String, password: String) {
        let attributes = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: username,
            kSecValueData: password.data(using: .utf8)!,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked
        ] as CFDictionary
        
        let status = SecItemAdd(attributes, nil)
        
        if status == errSecSuccess {
            print("Данные успешно сохранены в Keychain")
        } else {
            print("Ошибка при сохранении данных в Keychain: \(status)")
        }
    }
    
    /// Изменение значения пароля
    func update(newPassword: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
        ]
        
        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: newPassword.data(using: .utf8)!,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        if status == errSecSuccess {
            print("Пароль в keychain успешно обновлен")
        } else {
            print("Ошибка при обновлении пароля в keychain")
        }
    }
    
    /// Удаление значения логина и пароля из keychain
    func delete() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess {
            if let existingItem = item as? [String: Any],
               let passwordData = existingItem[kSecValueData as String] as? Data {
                let deleteQuery: [String: Any] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecValueData as String: passwordData
                ]
                
                let deleteStatus = SecItemDelete(deleteQuery as CFDictionary)
                if deleteStatus == errSecSuccess {
                    print("Учетные данные успешно удалены из Keychain")
                } else {
                    print("Ошибка при удалении учетных данных из Keychain: \(deleteStatus)")
                }
            }
        } else {
            print("Ошибка при поиске учетных данных в Keychain: \(status)")
        }
    }
    
    /// Проверка на наличие значения логина и пароля в keychain
    func checkValue(username: String, password: String) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: username,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        if status == errSecSuccess {
            let passwordData = result as! Data
            let savedPassword = String(data: passwordData, encoding: .utf8)
            
            if savedPassword == password {
                print("Логин и пароль совпадают")
                return true
            } else {
                print("Неверный пароль")
                return false
            }
        } else {
            print("Ошибка при получении данных из Keychain: \(status)")
            return false
        }
    }
}
