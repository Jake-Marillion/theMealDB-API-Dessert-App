//
//  ListViewTableViewController.swift
//  theMealDB API Dessert App
//
//  Created by Jacob Marillion on 5/11/23.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    //MARK: - Properties
    let gradientLayer = CAGradientLayer()
    var desserts: [ListObject] = []
    
    //MARK: - Outlets
    @IBOutlet var listTableView: UITableView!
    
    
    //MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Desserts!"
        listTableView.register(UINib(nibName: "DessertTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomDessertCell")
        
        APIController.fetchDesserts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let desserts):
                    self.desserts = desserts
                    self.listTableView.reloadData()
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                }
            }
        }
        
    }
    
    //MARK: - Helper Functions
    func setUpGradient() {
        let backgroundView = UIView(frame: listTableView.bounds)
        gradientLayer.frame = listTableView.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.orange.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.orange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        listTableView.backgroundView = backgroundView
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        desserts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomDessertCell", for: indexPath) as! DessertTableViewCell
        let dessert = desserts[indexPath.row]
        
        cell.listObject = dessert

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetailVC", sender: self)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = listTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? DetailViewController else { return }
            let dessertIdToSend = desserts[indexPath.row].idMeal
            
            destinationVC.currentDessertId = dessertIdToSend
        }
    }

} //End of class
