//
//  DetailViewController.swift
//  theMealDB API Dessert App
//
//  Created by Jacob Marillion on 5/11/23.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {

    //MARK: - Properties
    var currentDessertId: String?
    var currentDessertArray: [DetailObject]?
    var isFavorite: Bool = false
    let gradientLayer = CAGradientLayer()
    
    //MARK: - Outlets
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var nameWhiteBackground: UIView!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var ingedientsWhiteBackground: UIView!
    @IBOutlet weak var instructionsWhiteBackground: UIView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    
    //MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .purple
        self.navigationController?.navigationBar.backItem?.title = "Desserts"
        self.navigationController?.navigationBar.layer.opacity = 0.8
        
        if isFavorite == true {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        APIController.fetchOneDessert(id: currentDessertId ?? "") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let desserts):
                    self.currentDessertArray = desserts
                    self.assignValues()
                    print("zzz \(self.currentDessertArray)")
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpGradient()
        setUpViews()
    }
    
    //MARK: - Helper Functions
    func assignValues() {
        guard let currentDessert = currentDessertArray?.first else { return }
        ingredientsTextView.text = ""
        mealNameLabel.text = currentDessert.strMeal
        
        if currentDessert.strIngredient1?.count ?? 0 > 2 {
            ingredientsTextView.text += "\(currentDessert.strIngredient1 ?? "") - \(currentDessert.strMeasure1 ?? "")"
        }
        if currentDessert.strIngredient2?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient2 ?? "") - \(currentDessert.strMeasure2 ?? "")"
        }
        if currentDessert.strIngredient3?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient3 ?? "") - \(currentDessert.strMeasure3 ?? "")"
        }
        if currentDessert.strIngredient4?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient4 ?? "") - \(currentDessert.strMeasure4 ?? "")"
        }
        if currentDessert.strIngredient5?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient5 ?? "") - \(currentDessert.strMeasure5 ?? "")"
        }
        if currentDessert.strIngredient6?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient6 ?? "") - \(currentDessert.strMeasure6 ?? "")"
        }
        if currentDessert.strIngredient7?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient7 ?? "") - \(currentDessert.strMeasure7 ?? "")"
        }
        if currentDessert.strIngredient8?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient8 ?? "") - \(currentDessert.strMeasure8 ?? "")"
        }
        if currentDessert.strIngredient9?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient9 ?? "") - \(currentDessert.strMeasure9 ?? "")"
        }
        if currentDessert.strIngredient10?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient10 ?? "") - \(currentDessert.strMeasure10 ?? "")"
        }
        if currentDessert.strIngredient11?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient11 ?? "") - \(currentDessert.strMeasure11 ?? "")"
        }
        if currentDessert.strIngredient12?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient12 ?? "") - \(currentDessert.strMeasure12 ?? "")"
        }
        if currentDessert.strIngredient13?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient13 ?? "") - \(currentDessert.strMeasure13 ?? "")"
        }
        if currentDessert.strIngredient14?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient14 ?? "") - \(currentDessert.strMeasure14 ?? "")"
        }
        if currentDessert.strIngredient15?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient15 ?? "") - \(currentDessert.strMeasure15 ?? "")"
        }
        if currentDessert.strIngredient16?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient16 ?? "") - \(currentDessert.strMeasure16 ?? "")"
        }
        if currentDessert.strIngredient17?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient17 ?? "") - \(currentDessert.strMeasure17 ?? "")"
        }
        if currentDessert.strIngredient18?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient18 ?? "") - \(currentDessert.strMeasure18 ?? "")"
        }
        if currentDessert.strIngredient19?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient19 ?? "") - \(currentDessert.strMeasure19 ?? "")"
        }
        if currentDessert.strIngredient20?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient20 ?? "") - \(currentDessert.strMeasure20 ?? "")"
        }
        
        
        instructionsTextView.text = currentDessert.strInstructions
        APIController.fetchThumbnailFor(thumbnailId: currentDessert.strMealThumb) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let thumbnail):
                    self.mealImageView.image = thumbnail
                case .failure(let error):
                    self.mealImageView.image = UIImage(systemName: "photo.on.rectangle")
                    print("zzz Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                }
            }
        }
        
    }
    
    func setUpGradient() {
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.white.cgColor, UIColor.purple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setUpViews() {
        nameWhiteBackground.layer.shadowColor = UIColor.black.cgColor
        nameWhiteBackground.layer.shadowOpacity = 0.6
        nameWhiteBackground.layer.shadowOffset = CGSize(width: 3, height: 3)
        nameWhiteBackground.layer.shadowRadius = 3
        nameWhiteBackground.layer.cornerRadius = 10
        
        ingedientsWhiteBackground.layer.shadowColor = UIColor.black.cgColor
        ingedientsWhiteBackground.layer.shadowOpacity = 0.6
        ingedientsWhiteBackground.layer.shadowOffset = CGSize(width: 3, height: 3)
        ingedientsWhiteBackground.layer.shadowRadius = 3
        ingedientsWhiteBackground.layer.cornerRadius = 10
        
        instructionsWhiteBackground.layer.shadowColor = UIColor.black.cgColor
        instructionsWhiteBackground.layer.shadowOpacity = 0.6
        instructionsWhiteBackground.layer.shadowOffset = CGSize(width: 3, height: 3)
        instructionsWhiteBackground.layer.shadowRadius = 3
        instructionsWhiteBackground.layer.cornerRadius = 10
        
        mealImageView.layer.cornerRadius = 10
        mealImageView.clipsToBounds = true
    }

    @IBAction func heartButtonPressed(_ sender: UIButton) {
        let hapticFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        let upSoundId: SystemSoundID = 1004
        let downSoundId: SystemSoundID = 1003
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 1
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: heartButton.center.x, y: heartButton.center.y + 10))
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: heartButton.center.x, y: heartButton.center.y - 10))
        
        heartButton.layer.add(shakeAnimation, forKey: "position")
        hapticFeedbackGenerator.impactOccurred(intensity: 1.0)
        if isFavorite == true {
            AudioServicesPlaySystemSound(downSoundId)
            CoreDataController.deleteFavorite(id: currentDessertId ?? "")
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            isFavorite = false
        } else {
            AudioServicesPlaySystemSound(upSoundId)
            let newFavObject: Favorite = Favorite(id: currentDessertId ?? "")
            CoreDataController.saveFavorite()
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isFavorite = true
        }
        
    }
    
} //End of class
