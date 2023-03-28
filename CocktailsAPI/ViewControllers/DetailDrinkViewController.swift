//
//  ViewController.swift
//  CocktailsAPI
//
//  Created by Roman Lantsov on 20.03.2023.
//

import UIKit

final class DetailDrinkViewController: UIViewController {

    @IBOutlet var drinkImage: UIImageView!
    @IBOutlet var drinkNameLabel: UILabel!
    @IBOutlet var drinkCategoryLabel: UILabel!
    @IBOutlet var drinkGlassLabel: UILabel!
    @IBOutlet var isAlcoholicLabel: UILabel!
    @IBOutlet var drinkIngredientsLabel: UILabel!
    @IBOutlet var drinkRecipeLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    var drink: Drink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        setupLabels()
    }
    
//MARK: - Private methods
    
    private func loadImage() {
        networkManager.fetchImage(from: drink.strDrinkThumb) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.drinkImage.image = UIImage(data: imageData)
                self?.drinkImage.layer.cornerRadius = (self?.drinkImage.frame.height ?? 150) / 2
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupLabels() {
        drinkNameLabel.text = drink.strDrink
        drinkCategoryLabel.text = "Category: \(drink.strCategory)"
        drinkGlassLabel.text = "Glass: \(drink.strGlass)"
        isAlcoholicLabel.text = drink.strAlcoholic
        drinkIngredientsLabel.text = drink.ingredients
        drinkRecipeLabel.text = """
                                Recipe:
                                \(drink.strInstructions)
                                """
    }
}

