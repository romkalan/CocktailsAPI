//
//  NetworkManager.swift
//  CocktailsAPI
//
//  Created by Roman Lantsov on 23.03.2023.
//

import Foundation

enum Link {
    case drinksLink
    
    var url: URL {
        switch self {
        case .drinksLink:
           return URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
        func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}


