//
//  ViewController.swift
//  CocktailsAPI
//
//  Created by Roman Lantsov on 20.03.2023.
//

import UIKit


final class DetailDrinkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDrinksInfo()
    }
    
// MARK: - Private Methods
    private func fetchDrinksInfo() {
        URLSession.shared.dataTask(with: Link.drinksLink.url) { data, _, error in
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

