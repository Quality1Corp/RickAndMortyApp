//
//  EpisodeListViewModel.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 18.10.2023.
//

import Foundation

protocol EpisodeListViewModelProtocol {
    var episodes: [Episode] { get set }
    func fetchEpisode(from url: String, closure: @escaping(Episode) -> Void)
}

final class EpisodeListViewModel: EpisodeListViewModelProtocol {

    var episodes: [Episode] = []
    private let networkManager = NetworkManager.shared
    
    func fetchEpisode(from url: String, closure: @escaping(Episode) -> Void) {
        networkManager.fetch(Episode.self, from: url) { [unowned self] result in
            switch result {
                case .success(let episode):
                    self.episodes.append(episode)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
