//
//  ViewController.swift
//  CocktailsAPI
//
//  Created by Roman Lantsov on 20.03.2023.
//

import UIKit

final class ViewController: UIViewController {

    private let drinksLink = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDrinksInfo()
    }
    
// MARK: - Private Methods
    private func fetchDrinksInfo() {
        guard let url = URL(string: drinksLink) else { return }
        
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

