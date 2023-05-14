//
//  DessertTableViewCell.swift
//  theMealDB API Dessert App
//
//  Created by Jacob Marillion on 5/11/23.
//

import UIKit
import AVFoundation

class DessertTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var whiteBackground: UIView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var dessertNameLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customizeElements()
    }

    //MARK: - Properties
    weak var delegate: UpdateFavoriteDelegate?
    var listObject: ListObject? {
        didSet {
            updateCell()
        }
    }
    
    //MARK: - Helper Functions
    func updateCell() {
        guard let listObject = listObject else { return }
        let thumbnailId = listObject.strMealThumb
        
        dessertNameLabel.text = listObject.strMeal
        
        APIController.fetchThumbnailFor(thumbnailId: thumbnailId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let thumbnail):
                    self.thumbnailImage.image = thumbnail
                case .failure(let error):
                    self.thumbnailImage.image = UIImage(systemName: K.defaultImageName)
                    print("zzz Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                }
            }
        }
    }
    
    func customizeElements() {
        whiteBackground.layer.shadowColor = UIColor.black.cgColor
        whiteBackground.layer.shadowOpacity = 0.6
        whiteBackground.layer.shadowOffset = CGSize(width: 3, height: 3)
        whiteBackground.layer.shadowRadius = 3
        whiteBackground.layer.cornerRadius = 10
        
        thumbnailImage.layer.cornerRadius = 10
        thumbnailImage.clipsToBounds = true
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        guard let defaultImage: UIImage = UIImage(systemName: K.heart) else { return }
        let upSoundId: SystemSoundID = 1004
        let downSoundId: SystemSoundID = 1003
        let shakeAnimation = CABasicAnimation(keyPath: K.keyPath)
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 1
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: heartButton.center.x, y: heartButton.center.y + 10))
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: heartButton.center.x, y: heartButton.center.y - 10))
        heartButton.layer.add(shakeAnimation, forKey: K.keyPath)
        let name = dessertNameLabel.text ?? K.emptyString
        
        if heartButton.currentImage == UIImage(systemName: K.filledHeart) {
            AudioServicesPlaySystemSound(downSoundId)
            delegate?.removeFromFavoritesArray(name: name)
            heartButton.setImage(UIImage(systemName: K.heart), for: .normal)
        } else {
            AudioServicesPlaySystemSound(upSoundId)
            delegate?.addToFavoritesArray(name: name)
            heartButton.setImage(UIImage(systemName: K.filledHeart), for: .normal)
        }
    }
    
} //End of class
