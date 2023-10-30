//
//  ListCharactersCell.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 09.10.2023.
//

import UIKit

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
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        guard let url = URL(string: character?.image ?? "") else { return }
        
        networkManager.fetchImage(from: url) { [unowned self] result in
            switch result {
                case .success(let imageData):
                    
                    if let cachedImageData = self.networkManager.imageCache.object(forKey: url as NSURL) {
                        print("Данные отображены из кеша")
                    } else {
                        print("Данные получены из сети")
                    }
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)
                        self.charImage.image = image
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    private func setupView() {
        contentView.addSubview(contentContainerView)
        contentView.addSubview(charImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(genderLabel)
        
        contentContainerView.layer.borderWidth = 2
        contentContainerView.layer.borderColor = UIColor.blue.cgColor
        contentContainerView.layer.cornerRadius = 10
        contentContainerView.layer.masksToBounds = true
        contentView.backgroundColor = #colorLiteral(red: 0.6748661399, green: 0.8078844547, blue: 0.6908774376, alpha: 1)
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
            nameLabel.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -5),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            statusLabel.leadingAnchor.constraint(equalTo: charImage.trailingAnchor, constant: 20),
            genderLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            genderLabel.leadingAnchor.constraint(equalTo: charImage.trailingAnchor, constant: 20)
        ])
    }
}
