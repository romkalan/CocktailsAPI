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
    let strIBA: String?
    let strAlcoholic: Alcoholic
    let strGlass: String
    let strInstructions: String
    let strDrinkThumb: URL
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    
    let strImageAttribution: String?
}

enum Alcoholic: String, Decodable {
    case alcoholic = "Alcoholic"
    case nonAlcoholic = "non Alcoholic"
}

struct Drinks: Decodable {
    let drinks: [Drink]
}
