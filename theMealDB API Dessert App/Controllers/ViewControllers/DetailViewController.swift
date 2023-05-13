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
        self.navigationController?.navigationBar.layer.opacity = 0.7
        
        APIController.fetchOneDessert(id: currentDessertId ?? "") { result in
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
        
        mealNameLabel.text = currentDessert.strMeal
        //ingredientsTextView.text = currentDessert.strIngredient1
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
        
            //MARK: - TODO - This is not working on the first tap.
        hapticFeedbackGenerator.impactOccurred(intensity: 1.0)
        if heartButton.currentImage == UIImage(systemName: "heart") {
            AudioServicesPlaySystemSound(upSoundId)
            //save id to favs and play shake animation?
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            AudioServicesPlaySystemSound(downSoundId)
            //delete id from favs and play shake animation?
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
} //End of class
