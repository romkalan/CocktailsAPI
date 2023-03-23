//
//  AddNewDrinkViewController.swift
//  CocktailsAPI
//
//  Created by Roman Lantsov on 23.03.2023.
//

import UIKit

class AddNewDrinkViewController: UITableViewController {

    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBOutlet var drinkNameTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var glassTextField: UITextField!
    @IBOutlet var isAlcoholicTextField: UITextField!
    @IBOutlet var imageTextField: UITextField!
    @IBOutlet var recipeTextField: UITextField!
    
    @IBOutlet var ingredientsTextField: [UITextField]!
    @IBOutlet var measuresTextField: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    private func updateSaveButtonState() {
        let drinkName = drinkNameTextField.text ?? ""
        let drinkCategory = categoryTextField.text ?? ""
        let drinkImage = imageTextField.text ?? ""
        
        saveButton.isEnabled = !drinkName.isEmpty && !drinkCategory.isEmpty && !drinkImage.isEmpty
    }
    

    // MARK: - Table view data source

}
