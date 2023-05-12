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
    
    //MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            //MARK: - TODO - Verify
        self.navigationController?.navigationBar.tintColor = .purple
        self.navigationController?.navigationBar.topItem?.title = "All Recipies"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpGradient()
    }
    
    //MARK: - Helper Functions
    func setUpGradient() {
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.orange.cgColor, UIColor.orange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
    }

    @IBAction func heartButtonPressed(_ sender: UIButton) {
        let hapticFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        let upSoundId: SystemSoundID = 1004
        let downSoundId: SystemSoundID = 1003
        guard let emptyHeart: UIImage = UIImage(named: "heart"),
              let filledHeart: UIImage = UIImage(systemName: "heart.fill") else { return }

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
