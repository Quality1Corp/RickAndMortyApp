//
//  TextFieldFactory.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 03.11.2023.
//

import UIKit

protocol TextFieldFactory {
    func createTextField() -> UITextField
}

final class ShadowTextField: TextFieldFactory {
    let placeholder: String
    let isSecure: Bool?
    
    init(placeholder: String, isSecure: Bool?) {
        self.placeholder = placeholder
        self.isSecure = isSecure
    }
    
    func createTextField() -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        textField.font = .boldSystemFont(ofSize: 18)
        textField.textAlignment = .center
        textField.isSecureTextEntry = isSecure ?? false
        
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.4
        textField.layer.shadowOffset = CGSize(width: 15, height: 15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
