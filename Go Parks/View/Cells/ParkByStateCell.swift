//
//  ParkByStateCell.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-15.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

protocol ParkByStateCellDelegate: class {
  func favoritePressed(cell: ParkByStateCell)
}

class ParkByStateCell: UICollectionViewCell {
  static let ID = "ParkCollectionCell"
  var delegate: ParkByStateCellDelegate?
  
  @IBOutlet weak var parkPhoto: UIImageView!
  @IBOutlet weak var parkName: UILabel!
  @IBOutlet weak var favoriteImage: UIImageView!
  @IBOutlet weak var favoriteButton: UIButton!
  
  @IBAction func favoritePressed(_ sender: Any) {
    self.delegate?.favoritePressed(cell: self)
  }
  
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