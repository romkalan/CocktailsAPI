//
//  DrinkCell.swift
//  CocktailsAPI
//
//  Created by Roman Lantsov on 23.03.2023.
//

import UIKit

class DrinkCell: UITableViewCell {
    
    @IBOutlet var drinkImage: UIImageView!
    @IBOutlet var drinkNameLabel: UILabel!
    @IBOutlet var drinkCategoryLabel: UILabel!
    @IBOutlet var isAlcoholicLabel: UILabel!

    private let networkManager = NetworkManager.shared
    
    func configure(with drink: Drink) {
        drinkNameLabel.text = drink.strDrink ?? "no Name"
        drinkCategoryLabel.text = drink.strCategory ?? "No Category"
        isAlcoholicLabel.text = drink.strAlcoholic ?? "No information"
        
//        networkManager.fetchImage(from: course.imageUrl!) { [weak self] result in
//            switch result {
//            case .success(let imageData):
//                self?.drinkImage.image = UIImage(data: imageData)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}
