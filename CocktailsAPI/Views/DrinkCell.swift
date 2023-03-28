//
//  DrinkCell.swift
//  CocktailsAPI
//
//  Created by Roman Lantsov on 23.03.2023.
//

import UIKit

final class DrinkCell: UITableViewCell {
    
    @IBOutlet var drinkImage: UIImageView!
    @IBOutlet var drinkNameLabel: UILabel!
    @IBOutlet var drinkCategoryLabel: UILabel!
    @IBOutlet var isAlcoholicLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with drink: Drink) {
        drinkNameLabel.text = drink.strDrink
        drinkCategoryLabel.text = drink.strCategory
        isAlcoholicLabel.text = drink.strAlcoholic
        
        //MARK: - fetch image with URLSession
//        networkManager.fetchImage(from: drink.strDrinkThumb) { [weak self] result in
//            switch result {
//            case .success(let imageData):
//                self?.drinkImage.image = UIImage(data: imageData)
//                self?.drinkImage.layer.cornerRadius = (self?.drinkImage.frame.height ?? 150) / 2
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        //MARK: - fetch image with Alamofire
        networkManager.fetchImageWithAlamofire(from: drink.strDrinkThumb) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.drinkImage.image = UIImage(data: imageData)
                self?.drinkImage.layer.cornerRadius = (self?.drinkImage.frame.height ?? 150) / 2
            case .failure(let error):
                print(error)
            }
        }
    }
}
