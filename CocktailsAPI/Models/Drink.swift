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
    let strDrinkThumb: String
    
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
    
    var isFavorite: Bool?
    
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
    
    init(strDrink: String, strCategory: String, strAlcoholic: String, strGlass: String, strInstructions: String, strDrinkThumb: String, strIngredient1: String?, strIngredient2: String?, strIngredient3: String?, strIngredient4: String?, strIngredient5: String?, strMeasure1: String?, strMeasure2: String?, strMeasure3: String?, strMeasure4: String?, strMeasure5: String?, isFavorite: Bool? = nil) {
        self.strDrink = strDrink
        self.strCategory = strCategory
        self.strAlcoholic = strAlcoholic
        self.strGlass = strGlass
        self.strInstructions = strInstructions
        self.strDrinkThumb = strDrinkThumb
        self.strIngredient1 = strIngredient1
        self.strIngredient2 = strIngredient2
        self.strIngredient3 = strIngredient3
        self.strIngredient4 = strIngredient4
        self.strIngredient5 = strIngredient5
        self.strMeasure1 = strMeasure1
        self.strMeasure2 = strMeasure2
        self.strMeasure3 = strMeasure3
        self.strMeasure4 = strMeasure4
        self.strMeasure5 = strMeasure5
        self.isFavorite = isFavorite
    }
    
    init(drinkData: [String: Any]) {
        strDrink = drinkData["strDrink"] as? String ?? ""
        strCategory = drinkData["strCategory"] as? String ?? ""
        strAlcoholic = drinkData["strAlcoholic"] as? String ?? ""
        strGlass = drinkData["strGlass"] as? String ?? ""
        strInstructions = drinkData["strInstructions"] as? String ?? ""
        strDrinkThumb = drinkData["strDrinkThumb"] as? String ?? ""
        strIngredient1 = drinkData["strIngredient1"] as? String
        strIngredient2 = drinkData["strIngredient2"] as? String
        strIngredient3 = drinkData["strIngredient3"] as? String
        strIngredient4 = drinkData["strIngredient4"] as? String
        strIngredient5 = drinkData["strIngredient5"] as? String
        strMeasure1 = drinkData["strMeasure1"] as? String
        strMeasure2 = drinkData["strMeasure2"] as? String
        strMeasure3 = drinkData["strMeasure3"] as? String
        strMeasure4 = drinkData["strMeasure4"] as? String
        strMeasure5 = drinkData["strMeasure5"] as? String
    }
    
    static func getDrinks(from value: Any) -> [Drink] {
        guard let beveragesData = value as? [String: [[String: Any]]] else { return [] }
        guard let drinksData = beveragesData["drinks"] else { return [] }
        
        return drinksData.map { Drink(drinkData: $0) }
    }
}

struct Drinks: Decodable {
    var drinks: [Drink]
}
