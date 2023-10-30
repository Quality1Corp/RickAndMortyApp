//
//  EpisodeCell.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 29.10.2023.
//

import UIKit

final class EpisodeCell: UICollectionViewCell {
    
    static let identifier = "seriesCell"
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameEpisodeLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var episodeNumberLabel: UILabel = {
        var label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0.5090747476, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
