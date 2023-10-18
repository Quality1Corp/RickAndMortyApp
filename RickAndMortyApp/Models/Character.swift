//
//  Character.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 10.10.2023.
//

import Foundation

struct RickAndMorty: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let status: String
    let gender: String
    let image: String
    let episode: [String]
}
