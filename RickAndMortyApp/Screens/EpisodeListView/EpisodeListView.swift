//
//  EpisodeListView.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 29.10.2023.
//

import UIKit

final class EpisodeListView: UICollectionViewController {
    
    var character: Character!
    private var episode: Episode!
    
    // MARK: - Initialization
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20 , left: 60, bottom: 0, right: 60)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.6748661399, green: 0.8078844547, blue: 0.6908774376, alpha: 1)
        registerCollectionCells()
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        setupNavigationBar()
    }
    
    // MARK: - Private Methods
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupNavigationBar() {
        title = "Episodes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor.blue
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func registerCollectionCells() {
        collectionView.register(
            EpisodeCell.self,
            forCellWithReuseIdentifier: EpisodeCell.identifier
        )
    }
}

// MARK: - UICollectionViewDataSource
extension EpisodeListView {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        character.episode.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCell.identifier, for: indexPath) as? EpisodeCell else {
            return UICollectionViewCell()
        }
        let episode = character.episode[indexPath.item]
        cell.configure(episode)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension EpisodeListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 32, height: 86)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 20)
    }
}

// MARK: - Extension EpisodeListView
extension EpisodeListView {
    func fetchEpisode(from url: String) {
        NetworkManager.shared.fetch(Episode.self, from: url) { [weak self] result in
            switch result {
                case .success(let episode):
                    self?.episode = episode
                case .failure(let error):
                    print(error)
            }
        }
    }
}
