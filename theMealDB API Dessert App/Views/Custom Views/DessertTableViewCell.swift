//
//  DessertTableViewCell.swift
//  theMealDB API Dessert App
//
//  Created by Jacob Marillion on 5/11/23.
//

import UIKit

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
        let id = listObject.strMealThumb
        
        dessertNameLabel.text = listObject.strMeal
        
        APIController.fetchThumbnailFor(thumbnailId: id) { result in
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
        guard let defaultImage: UIImage = UIImage(named: "heart") else { return }
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.02
        shakeAnimation.repeatCount = 10
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: heartButton.center.x - 15, y: heartButton.center.y))
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: heartButton.center.x + 15, y: heartButton.center.y))
        
        heartButton.layer.add(shakeAnimation, forKey: "position")
        delegate?.updateFavorite(currentImage: (heartButton.currentImage ?? defaultImage))
    }
    
} //End of class
