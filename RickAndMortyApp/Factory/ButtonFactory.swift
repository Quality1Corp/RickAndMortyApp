//
//  ButtonFactory.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 03.11.2023.
//

import UIKit

protocol ButtonFactory {
    func createButton() -> UIButton
}

final class FilledButtonFactory: ButtonFactory {
    let title: String
    let color: UIColor
    let buttonPressed: Selector
    let buttonReleased: Selector
    
    init(title: String, color: UIColor, buttonPressed: Selector, buttonReleased: Selector) {
        self.title = title
        self.color = color
        self.buttonPressed = buttonPressed
        self.buttonReleased = buttonReleased
    }
    
    func createButton() -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.addTarget(self, action: buttonPressed, for: .touchUpInside)
        button.addTarget(self, action: buttonReleased, for: .touchDown)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .heavy)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
