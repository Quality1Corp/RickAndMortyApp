//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 09.10.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case rickAndMortyURL = "https://rickandmortyapi.com/api/character"
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    let imageCache = NSCache<NSURL, NSData>()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String, with completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        // Проверяем наличие данных изображения в кеше
        if let cachedImageData = imageCache.object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                completion(.success(cachedImageData as Data))
            }
        }
        
        // Загружаем данные, если их нет в кеше
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            
            // Сохраняем данные изображения в кеше
            self.imageCache.setObject(imageData as NSData, forKey: url as NSURL)
            
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
