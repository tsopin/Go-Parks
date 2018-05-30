//
//  ParkByStateCell.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-15.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class ParkByStateCell: UICollectionViewCell {
  static let ID = "ParkCollectionCell"
  
  @IBOutlet weak var parkPhoto: UIImageView!
  @IBOutlet weak var parkName: UILabel!
  @IBOutlet weak var favoriteImage: UIImageView!
  
 
  func configeureCell(name: String, photo: UIImage, isFavorite: Bool) {
    self.parkName.text = name
    self.parkPhoto.image = photo
    
    if isFavorite {
      favoriteImage.image = UIImage(named: "heartGreen")
    } else {
      favoriteImage.image = UIImage(named: "heartGrey")
    }
  }
}
