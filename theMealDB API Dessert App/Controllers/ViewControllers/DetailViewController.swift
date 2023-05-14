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
        self.navigationController?.navigationBar.backItem?.title = K.navBarTitle
        self.navigationController?.navigationBar.layer.opacity = 0.8
        
        if isFavorite == true {
            heartButton.setImage(UIImage(systemName: K.filledHeart), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: K.heart), for: .normal)
        }
        
        APIController.fetchOneDessert(id: currentDessertId ?? K.emptyString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let desserts):
                    self.currentDessertArray = desserts
                    self.assignValues()
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
        ingredientsTextView.text = K.emptyString
        mealNameLabel.text = currentDessert.strMeal
        
        if currentDessert.strIngredient1?.count ?? 0 > 2 {
            ingredientsTextView.text += "\(currentDessert.strIngredient1 ?? K.emptyString) - \(currentDessert.strMeasure1 ?? K.emptyString)"
        }
        if currentDessert.strIngredient2?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient2 ?? K.emptyString) - \(currentDessert.strMeasure2 ?? K.emptyString)"
        }
        if currentDessert.strIngredient3?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient3 ?? K.emptyString) - \(currentDessert.strMeasure3 ?? K.emptyString)"
        }
        if currentDessert.strIngredient4?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient4 ?? K.emptyString) - \(currentDessert.strMeasure4 ?? K.emptyString)"
        }
        if currentDessert.strIngredient5?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient5 ?? K.emptyString) - \(currentDessert.strMeasure5 ?? K.emptyString)"
        }
        if currentDessert.strIngredient6?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient6 ?? K.emptyString) - \(currentDessert.strMeasure6 ?? K.emptyString)"
        }
        if currentDessert.strIngredient7?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient7 ?? K.emptyString) - \(currentDessert.strMeasure7 ?? K.emptyString)"
        }
        if currentDessert.strIngredient8?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient8 ?? K.emptyString) - \(currentDessert.strMeasure8 ?? K.emptyString)"
        }
        if currentDessert.strIngredient9?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient9 ?? K.emptyString) - \(currentDessert.strMeasure9 ?? K.emptyString)"
        }
        if currentDessert.strIngredient10?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient10 ?? K.emptyString) - \(currentDessert.strMeasure10 ?? K.emptyString)"
        }
        if currentDessert.strIngredient11?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient11 ?? K.emptyString) - \(currentDessert.strMeasure11 ?? K.emptyString)"
        }
        if currentDessert.strIngredient12?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient12 ?? K.emptyString) - \(currentDessert.strMeasure12 ?? K.emptyString)"
        }
        if currentDessert.strIngredient13?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient13 ?? K.emptyString) - \(currentDessert.strMeasure13 ?? K.emptyString)"
        }
        if currentDessert.strIngredient14?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient14 ?? K.emptyString) - \(currentDessert.strMeasure14 ?? K.emptyString)"
        }
        if currentDessert.strIngredient15?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient15 ?? K.emptyString) - \(currentDessert.strMeasure15 ?? K.emptyString)"
        }
        if currentDessert.strIngredient16?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient16 ?? K.emptyString) - \(currentDessert.strMeasure16 ?? K.emptyString)"
        }
        if currentDessert.strIngredient17?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient17 ?? K.emptyString) - \(currentDessert.strMeasure17 ?? K.emptyString)"
        }
        if currentDessert.strIngredient18?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient18 ?? K.emptyString) - \(currentDessert.strMeasure18 ?? K.emptyString)"
        }
        if currentDessert.strIngredient19?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient19 ?? K.emptyString) - \(currentDessert.strMeasure19 ?? K.emptyString)"
        }
        if currentDessert.strIngredient20?.count ?? 0 > 2 {
            ingredientsTextView.text += "\n\(currentDessert.strIngredient20 ?? K.emptyString) - \(currentDessert.strMeasure20 ?? K.emptyString)"
        }
        
        
        instructionsTextView.text = currentDessert.strInstructions
        APIController.fetchThumbnailFor(thumbnailId: currentDessert.strMealThumb) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let thumbnail):
                    self.mealImageView.image = thumbnail
                case .failure(let error):
                    self.mealImageView.image = UIImage(systemName: K.defaultImageName)
                    print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
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
        let shakeAnimation = CABasicAnimation(keyPath: K.keyPath)
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 1
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: heartButton.center.x, y: heartButton.center.y + 10))
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: heartButton.center.x, y: heartButton.center.y - 10))
        
        heartButton.layer.add(shakeAnimation, forKey: K.keyPath)
        hapticFeedbackGenerator.impactOccurred(intensity: 1.0)
        if isFavorite == true {
            AudioServicesPlaySystemSound(downSoundId)
            CoreDataController.deleteFavorite(id: currentDessertId ?? K.emptyString)
            heartButton.setImage(UIImage(systemName: K.heart), for: .normal)
            isFavorite = false
        } else {
            AudioServicesPlaySystemSound(upSoundId)
            let newFavObject: Favorite = Favorite(id: currentDessertId ?? K.emptyString)
            CoreDataController.saveFavorite()
            heartButton.setImage(UIImage(systemName: K.filledHeart), for: .normal)
            isFavorite = true
        }
        
    }
    
} //End of class
