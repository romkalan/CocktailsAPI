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
    
    func fetch(from url: URL, completion: @escaping(Result<[Drink], AFError>) -> Void) {
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
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
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


