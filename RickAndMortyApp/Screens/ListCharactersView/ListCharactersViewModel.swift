//
//  ListCharactersViewModel.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 09.10.2023.
//

import Foundation

final class ListCharactersViewModel {
    
    var characters: [Character] = []
    private let networkManager = NetworkManager.shared
    
    func fetchCharacter(from url: URL, closure: @escaping(RickAndMorty) -> Void) {
        networkManager.fetch(RickAndMorty.self, from: url) { [unowned self] result in
            switch result {
                case .success(let char):
                    closure(char)
                    print(char)
                    self.characters.append(contentsOf: char.results)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func numberOfCharacters() -> Int {
        characters.count
    }
    
    func character(at index: Int) -> Character {
        characters[index]
    }
}
