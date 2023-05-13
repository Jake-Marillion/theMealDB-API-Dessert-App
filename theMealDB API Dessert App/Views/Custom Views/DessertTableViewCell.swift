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
                    self.thumbnailImage.image = UIImage(systemName: "photo.on.rectangle")
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
        guard let defaultImage: UIImage = UIImage(systemName: "heart") else { return }
        let upSoundId: SystemSoundID = 1004
        let downSoundId: SystemSoundID = 1003
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 1
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: heartButton.center.x, y: heartButton.center.y + 10))
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: heartButton.center.x, y: heartButton.center.y - 10))
        
        heartButton.layer.add(shakeAnimation, forKey: "position")
        
        if heartButton.currentImage == UIImage(systemName: "heart.fill") {
            AudioServicesPlaySystemSound(downSoundId)
            //play shake animation?
            CoreDataController.deleteFavorite(id: "")
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            AudioServicesPlaySystemSound(upSoundId)
            //play shake animation?
            let newFavObject: Favorite = Favorite(id: "")
            CoreDataController.saveFavorite()
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
            //MARK: - TODO - Why am I handing this off to the delegate here??  Why not perform all UI Changes here and then hand off the id for save or delete or just do it all here?  How do I get the current ID here??  Once known replace empty strings Jake.
        delegate?.updateFavoritesArray(id: "")
    }
    
} //End of class
