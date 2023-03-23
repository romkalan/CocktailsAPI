//
//  DrinkListViewController.swift
//  CocktailsAPI
//
//  Created by Roman Lantsov on 23.03.2023.
//

import UIKit

class DrinksListViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var drinks = Drinks(drinks: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 130
        navigationItem.leftBarButtonItem = editButtonItem
        fetchDrinks()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailDrinkVC = segue.destination as? DetailDrinkViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        detailDrinkVC.drink = drinks.drinks[indexPath.row]
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard let addNewDrinkVC = segue.source as? AddNewDrinkViewController else { return }
        drinks.drinks.append(
            Drink(
                strDrink: addNewDrinkVC.drinkNameTextField.text ?? "",
                strCategory: addNewDrinkVC.categoryTextField.text ?? "",
                strAlcoholic: addNewDrinkVC.isAlcoholicTextField.text ?? "",
                strGlass: addNewDrinkVC.glassTextField.text ?? "",
                strInstructions: addNewDrinkVC.recipeTextField.text ?? "",
                strDrinkThumb: URL(string: addNewDrinkVC.imageTextField.text ?? "") ?? Link.plug.url,
                strIngredient1: addNewDrinkVC.ingredientsTextField[0].text ?? "",
                strIngredient2: addNewDrinkVC.ingredientsTextField[1].text ?? "",
                strIngredient3: addNewDrinkVC.ingredientsTextField[2].text ?? "",
                strIngredient4: addNewDrinkVC.ingredientsTextField[3].text ?? "",
                strIngredient5: addNewDrinkVC.ingredientsTextField[4].text ?? "",
                strMeasure1: addNewDrinkVC.measuresTextField[0].text ?? "",
                strMeasure2: addNewDrinkVC.measuresTextField[1].text ?? "",
                strMeasure3: addNewDrinkVC.measuresTextField[2].text ?? "",
                strMeasure4: addNewDrinkVC.measuresTextField[3].text ?? "",
                strMeasure5: addNewDrinkVC.measuresTextField[4].text ?? ""
            )
        )
        tableView.reloadData()
    }
}

// MARK: - Table view data source
extension DrinksListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drinks.drinks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drink", for: indexPath)
        guard let cell = cell as? DrinkCell else { return UITableViewCell() }
        let drink = drinks.drinks[indexPath.row]
        cell.configure(with: drink)
        
        return cell
    }
}

// MARK: - Table view delegate
extension DrinksListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            drinks.drinks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let drink = drinks.drinks.remove(at: sourceIndexPath.row)
        drinks.drinks.insert(drink, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [favourite])
    }
}

//MARK: - Private Methods
extension DrinksListViewController {
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var drink = drinks.drinks[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") { [unowned self] (action, view, completion) in
            drink.isFavourite = !(drink.isFavourite ?? false)
            drinks.drinks[indexPath.row] = drink
            completion(true)
        }
        action.backgroundColor = drink.isFavourite ?? false ? .systemMint : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}

// MARK: - Networking
extension DrinksListViewController {

    func fetchDrinks() {
        networkManager.fetch(Drinks.self, from: Link.drinksLink.url) { [weak self] result in
            switch result {
            case .success(let drinks):
                self?.drinks = drinks
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                print(drinks)
            case .failure(let error):
                print(error)
            }
        }
    }
}
