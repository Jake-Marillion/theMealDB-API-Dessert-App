//
//  ListViewTableViewController.swift
//  theMealDB API Dessert App
//
//  Created by Jacob Marillion on 5/11/23.
//

import UIKit

protocol UpdateFavoriteDelegate: AnyObject {
    func addToFavoritesArray(name: String)
    func removeFromFavoritesArray(name: String)
} //End of protocol

class ListTableViewController: UIViewController {
    
    //MARK: - Properties
    let gradientLayer = CAGradientLayer()
    var desserts: [ListObject] = []
    var favorites: [String] = []
    
    //MARK: - Outlets
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet var backgroundView: UIView!
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: K.nibName, bundle: nil), forCellReuseIdentifier: K.customCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        APIController.fetchAllDesserts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let desserts):
                    self.desserts = desserts
                    self.listTableView.reloadData()
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                    self.presentAlertToUser()
                }
            }
        }
        
        favorites = CoreDataController.fetchAllFavorites()
        listTableView.reloadData()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpGradient()
    }
    
    //MARK: - Helper Functions
    func setUpGradient() {
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.white.cgColor, UIColor.purple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func presentAlertToUser() {
        let alertController = UIAlertController(title: K.listErrorAlertTitle, message: K.listErrorAlertMessage, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: K.ok, style: .cancel)
        
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }

} //End of class

//MARK: - Table View
extension ListTableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        desserts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.customCellId, for: indexPath) as! DessertTableViewCell
        let dessert = desserts[indexPath.row]
        
        cell.delegate = self
        cell.listObject = dessert
        
        if favorites.contains(dessert.idMeal) {
            cell.heartButton.setImage(UIImage(systemName: K.filledHeart), for: .normal)
        } else {
            cell.heartButton.setImage(UIImage(systemName: K.heart), for: .normal)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: K.toDetailSegueId, sender: self)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.toDetailSegueId {
            guard let indexPath = listTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? DetailViewController else { return }
            let dessertIdToSend = desserts[indexPath.row].idMeal
            
            if favorites.contains(dessertIdToSend) {
                destinationVC.isFavorite = true
            } else {
                destinationVC.isFavorite = false
            }
            destinationVC.currentDessertId = dessertIdToSend
        }
    }
    
} //End of extension

//MARK: - Update Favorites
extension ListTableViewController: UpdateFavoriteDelegate {
    
    func addToFavoritesArray(name: String) {
        guard let index = desserts.firstIndex(where: { $0.strMeal == name}) else { return }
        let id = desserts[index].idMeal
        favorites.append(id)
        let newFavObject: Favorite = Favorite(id: id)
        CoreDataController.saveFavorite()
    }
    
    func removeFromFavoritesArray(name: String) {
        guard let index = desserts.firstIndex(where: { $0.strMeal == name}) else { return }
        let id = desserts[index].idMeal
        favorites = favorites.filter{$0 != id}
        CoreDataController.deleteFavorite(id: id)
    }
    
} //End of extension
