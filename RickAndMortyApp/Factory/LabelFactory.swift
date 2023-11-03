//
//  LabelFactory.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 03.11.2023.
//

import UIKit

protocol LabelFactory {
    func createLabel() -> UILabel
}

final class DefaultLabelFactory: LabelFactory {
    let font: UIFont
    let color: UIColor
    
    init(font: UIFont, color: UIColor) {
        self.font = font
        self.color = color
    }
    
    func createLabel() -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
