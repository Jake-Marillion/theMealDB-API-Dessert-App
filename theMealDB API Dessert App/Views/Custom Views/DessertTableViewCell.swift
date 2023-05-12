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
    @IBOutlet weak var heartImage: UIImageView!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addShadow()
    }

    //MARK: - Properties
    var listObject: ListObject? {
        didSet {
            updateCell()
        }
    }
    
    //MARK: - Helper Functions
    func updateCell() {
        guard let listObject = listObject else { return }
        
        dessertNameLabel.text = listObject.strMeal
        
        APIController.fetchThumbnailFor(listObject: listObject) { result in
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
    
    func addShadow() {
        whiteBackground.layer.shadowColor = UIColor.black.cgColor
        whiteBackground.layer.shadowOpacity = 0.5
        whiteBackground.layer.shadowOffset = .zero
        whiteBackground.layer.shadowRadius = 5
    }
    
} //End of class
