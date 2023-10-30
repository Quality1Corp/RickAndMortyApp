//
//  EpisodeListViewModel.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 18.10.2023.
//

import Foundation

final class EpisodeListViewModel {
    
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
