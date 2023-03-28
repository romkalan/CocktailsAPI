//
//  NetworkManager.swift
//  CocktailsAPI
//
//  Created by Roman Lantsov on 23.03.2023.
//

import Foundation
import Alamofire

enum Link {
    case drinksLink
    case plug
    
    var url: URL {
        switch self {
        case .drinksLink:
           return URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita")!
        case .plug:
            return URL(string: "https://runaev.ru/image/cache/placeholder-1000x1000.png")!
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
    
//MARK: - fetch with URLSession
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
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
//MARK: - fetch with alamofire
    func fetchWithAlamofire(from url: URL, completion: @escaping(Result<[Drink], AFError>) -> Void) {
        AF.request(Link.drinksLink.url)
            .validate()
            .responseJSON { dataResponse in
                guard let statusCode = dataResponse.response?.statusCode else { return }
                print("STATUS CODE: ", statusCode)
                
                switch dataResponse.result {
                case .success(let value):
                    let drinks = Drink.getDrinks(from: value)
                    completion(.success(drinks))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImageWithAlamofire(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}


