//
//  AddNewDrinkViewController.swift
//  CocktailsAPI
//
//  Created by Roman Lantsov on 23.03.2023.
//

import UIKit

final class AddNewDrinkViewController: UITableViewController {
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBOutlet var drinkNameTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var glassTextField: UITextField!
    @IBOutlet var isAlcoholicTextField: UITextField!
    @IBOutlet var imageTextField: UITextField!
    @IBOutlet var recipeTextField: UITextField!
        
    @IBOutlet var ingredientTextField1: UITextField!
    @IBOutlet var ingredientTextField2: UITextField!
    @IBOutlet var ingredientTextField3: UITextField!
    @IBOutlet var ingredientTextField4: UITextField!
    @IBOutlet var ingredientTextField5: UITextField!
    
    @IBOutlet var measureTextField1: UITextField!
    @IBOutlet var measureTextField2: UITextField!
    @IBOutlet var measureTextField3: UITextField!
    @IBOutlet var measureTextField4: UITextField!
    @IBOutlet var measureTextField5: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        endEditingKeyboard()
        updateSaveButtonState()
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
//MARK: - Private methods
    private func updateSaveButtonState() {
        let drinkName = drinkNameTextField.text ?? ""
        let drinkCategory = categoryTextField.text ?? ""
        let drinkImage = imageTextField.text ?? ""
        let isAlcoholic = isAlcoholicTextField.text ?? ""
        
        saveButton.isEnabled = !drinkName.isEmpty &&
                             !drinkCategory.isEmpty &&
                             !drinkImage.isEmpty &&
                             !isAlcoholic.isEmpty
    }
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func endEditingKeyboard() {
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        dismissKeyboardGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(dismissKeyboardGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
//MARK: - UITextFieldDelegate
extension AddNewDrinkViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            showAlert(title: "Attention", message: "This text field cannot be empty, please enter information")
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
