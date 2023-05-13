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
    //var currentDessert: []?
    let gradientLayer = CAGradientLayer()
    
    //MARK: - Outlets
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var nameWhiteBackground: UIView!
    @IBOutlet weak var mealImageView: UIImageView!
    
    //MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            //MARK: - TODO - Fix this
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .purple
        self.navigationController?.navigationBar.backItem?.title = "Desserts"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpGradient()
        setUpViews()
    }
    
    //MARK: - Helper Functions
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
        
        mealImageView.layer.cornerRadius = 10
        mealImageView.clipsToBounds = true
    }

    @IBAction func heartButtonPressed(_ sender: UIButton) {
        let hapticFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        let upSoundId: SystemSoundID = 1004
        let downSoundId: SystemSoundID = 1003
        
        hapticFeedbackGenerator.impactOccurred(intensity: 1.0)
        if heartButton.currentImage == UIImage(systemName: "heart") {
            AudioServicesPlaySystemSound(upSoundId)
            //save id to favs and recall array and shake animation?
        } else {
            AudioServicesPlaySystemSound(downSoundId)
            //delete id from favs and reload and shake animation?
        }
    }
    
} //End of class
