//
//  ListCharactersCell.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 09.10.2023.
//

import UIKit
import SDWebImage

final class ListCharactersCell: UITableViewCell {
    
    static let identifier = "LocationCollectionViewCell"
    private let networkManager = NetworkManager.shared
    
    lazy var contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = DefaultLabelFactory(
            font: .boldSystemFont(ofSize: 20),
            color: .black
        )
        return label.createLabel()
    }()
    
    lazy var statusLabel: UILabel = {
        let label = DefaultLabelFactory(
            font: .systemFont(ofSize: 18),
            color: #colorLiteral(red: 0, green: 0.5090747476, blue: 0, alpha: 1)
        )
        return label.createLabel()
    }()
    
    lazy var genderLabel: UILabel = {
        let label = DefaultLabelFactory(
            font: .systemFont(ofSize: 18),
            color: #colorLiteral(red: 0, green: 0.5090747476, blue: 0, alpha: 1)
        )
        return label.createLabel()
    }()
    
    lazy var charImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with character: Character?) {
        nameLabel.text = character?.name
        statusLabel.text = "Status: \(character?.status ?? "")"
        genderLabel.text = "Gender: \(character?.gender ?? "")"
        
        let imageUrl = URL(string: character?.image ?? "")
        
        // Загрузка изображение в кеш
        charImage.sd_setImage(with: imageUrl) { (image, error, _, _) in
            if let error = error {
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
            } else {
                print("Изображение успешно загруженно")
            }
            
            // Сохранение изображения в память устройства
            if let image = image {
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                let imagePath = documentsDirectory?.appendingPathComponent("image.jpg")
                if let imagePath = imagePath {
                    do {
                        try image.jpegData(compressionQuality: 1)?.write(to: imagePath)
                        print("Изображение сохранено по пути: \(imagePath)")
                    } catch {
                        print("Ошибка сохранения изображения: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    private func setupView() {
        setupSubviews(
            contentContainerView,
            charImage,
            nameLabel,
            statusLabel,
            genderLabel
        )
        
        contentContainerView.layer.borderWidth = 2
        contentContainerView.layer.borderColor = UIColor.blue.cgColor
        contentContainerView.layer.cornerRadius = 10
        contentContainerView.layer.masksToBounds = true
        contentView.backgroundColor = #colorLiteral(red: 0.6748661399, green: 0.8078844547, blue: 0.6908774376, alpha: 1)
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            contentContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            charImage.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 20),
            charImage.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 10),
            charImage.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor,constant: -20),
            charImage.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: charImage.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -10),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            statusLabel.leadingAnchor.constraint(equalTo: charImage.trailingAnchor, constant: 20),
            genderLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            genderLabel.leadingAnchor.constraint(equalTo: charImage.trailingAnchor, constant: 20)
        ])
    }
}
