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
        tableView.rowHeight = 100
        fetchDrinks()
    }

    // MARK: - Table view data source

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Networking
extension DrinksListViewController {

    private func fetchDrinks() {
        networkManager.fetch(Drinks.self, from: Link.drinksLink.url) { [weak self] result in
            switch result {
            case .success(let drinks):
                self?.tableView.reloadData()
                print(drinks)
            case .failure(let error):
                print(error)
            }
        }
    }
}

//extension DrinksListViewController {
//    func fetchDrink() {
//        URLSession.shared.dataTask(with: Link.drinksLink.url) { [weak self] data, _, error in
//            guard let data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                self?.drinks = try decoder.decode(Drinks.self, from: data)
//                DispatchQueue.main.async {
//                    self?.tableView.reloadData()
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
//}
