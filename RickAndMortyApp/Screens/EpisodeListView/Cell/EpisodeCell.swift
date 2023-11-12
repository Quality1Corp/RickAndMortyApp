//
//  EpisodeCell.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 29.10.2023.
//

import UIKit

final class EpisodeCell: UICollectionViewCell {
    
    static let identifier = "seriesCell"
    
    // MARK: - Private properties
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameEpisodeLabel: UILabel = {
        var label = DefaultLabelFactory(
            font: .boldSystemFont(ofSize: 17),
            color: .black
        )
        return label.createLabel()
    }()
    
    private lazy var episodeNumberLabel: UILabel = {
        var label = DefaultLabelFactory(
            font: .systemFont(ofSize: 15),
            color: #colorLiteral(red: 0, green: 0.5090747476, blue: 0, alpha: 1)
        )
        return label.createLabel()
    }()
    
    private lazy var dateLabel: UILabel = {
        var label = DefaultLabelFactory(
            font: .systemFont(ofSize: 14),
            color: .gray
        )
        return label.createLabel()
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(_ episodeURL: String) {
        NetworkManager.shared.fetch(Episode.self, from: episodeURL) { [weak self] result in
            switch result {
                case .success(let episode):
                    self?.nameEpisodeLabel.text = episode.name
                    self?.dateLabel.text = episode.date
                    self?.episodeNumberLabel.text = self?.formatEpisodeNumber(episode.episode)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    // MARK: - Private methods
    private func setupView() {
        contentView.addSubview(mainView)
        mainView.addSubview(nameEpisodeLabel)
        mainView.addSubview(episodeNumberLabel)
        mainView.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameEpisodeLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 15),
            nameEpisodeLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 15),
            nameEpisodeLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15),
            
            episodeNumberLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -15),
            episodeNumberLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 15),
            
            dateLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            dateLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15)
        ])
    }
    
    /// Функция для форматирования номера эпизода, "S01E01" -> "Episode 1, Season: 1"
    private func formatEpisodeNumber(_ episodeNumber: String) -> String {
        if let seasonRange = episodeNumber.range(of: "S(\\d{2})", options: .regularExpression),
           let episodeRange = episodeNumber.range(of: "E(\\d{2})", options: .regularExpression) {
            
            let seasonNumber = String(Int(episodeNumber[seasonRange].dropFirst()) ?? 0)
            let episodeNumber = String(Int(episodeNumber[episodeRange].dropFirst()) ?? 0)
            
            return "Episode: \(episodeNumber), Season: \(seasonNumber)"
        } else {
            return episodeNumber
        }
    }
}
