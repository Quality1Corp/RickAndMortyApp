//
//  ListCharactersViewModel.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 09.10.2023.
//

import Foundation

final class ListCharactersViewModel {
    
    var rickAndMorty: RickAndMorty?
    private let networkManager = NetworkManager.shared
    
    func fetchCharacter(from url: String, closure: @escaping(RickAndMorty) -> Void) {
        networkManager.fetch(RickAndMorty.self, from: url) { result in
            switch result {
                case .success(let rickAndMorty):
                    self.rickAndMorty = rickAndMorty
                    closure(rickAndMorty)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func numberOfCharacters() -> Int {
        rickAndMorty?.results.count ?? 0
    }
}
