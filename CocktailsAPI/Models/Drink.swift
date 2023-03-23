//
//  Drink.swift
//  CocktailsAPI
//
//  Created by Roman Lantsov on 20.03.2023.
//

import Foundation

struct Drink: Decodable {
    let strDrink: String
    let strCategory: String
    let strAlcoholic: String
    let strGlass: String
    let strInstructions: String
    let strDrinkThumb: URL
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
        
    var ingredients: String {
        """
        For its preparation you will need:
        \(strIngredient1 ?? "") \(strMeasure1 ?? "")
        \(strIngredient2 ?? "") \(strMeasure2 ?? "")
        \(strIngredient3 ?? "") \(strMeasure3 ?? "")
        \(strIngredient4 ?? "") \(strMeasure4 ?? "")
        \(strIngredient5 ?? "") \(strMeasure5 ?? "")
        """
    }
    
    var isFavourite: Bool?
}

struct Drinks: Decodable {
    var drinks: [Drink]
}
