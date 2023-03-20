//
//  ViewController.swift
//  CocktailsAPI
//
//  Created by Roman Lantsov on 20.03.2023.
//

import UIKit

let link = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInfo()
    }
    
// MARK: - Private Methods
    private func fetchInfo() {
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let drinks = try decoder.decode(Drinks.self, from: data)
                print(drinks)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}

