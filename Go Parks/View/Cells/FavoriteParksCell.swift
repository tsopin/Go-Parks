//
//  FavoriteParksCell.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-30.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

protocol FavoriteParksCellDelegate: class {
  func favoritePressed(cell: FavoriteParksCell)
}

class FavoriteParksCell: UICollectionViewCell {
  static let ID = "FavoriteParksCell"
  
  var delegate: FavoriteParksCellDelegate?
  let service = Service()
  
  @IBOutlet weak var parkPhoto: UIImageView!
  @IBOutlet weak var parkName: UILabel!
  @IBOutlet weak var favoriteButton: UIButton!
  
  @IBAction func favoritePressed(_ sender: UIButton) {
    self.delegate?.favoritePressed(cell: self)
    service.animateButton(sender)
  }
  
  func configeureCell(name: String, photo: UIImage, isFavorite: Bool) {
    self.parkName.text = name
    self.parkPhoto.image = photo
    
    if isFavorite {
      favoriteButton.setBackgroundImage(UIImage(named: "heartGreen"), for: .normal)
    } else {
      favoriteButton.setBackgroundImage(UIImage(named: "heartGrey"), for: .normal)
    }
  }
}
