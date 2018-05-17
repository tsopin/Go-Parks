//
//  ParkByPhotoCell.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-15.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class ParkByPhotoCell: UICollectionViewCell {
  static let ID = "ParkByPhotoCell"
    
  @IBOutlet weak var parkPhoto: UIImageView!
  @IBOutlet weak var parkName: UILabel!
  
  func dropShadow() {
    self.contentView.layer.cornerRadius = 10.0
    self.contentView.layer.borderWidth = 1.0
    self.contentView.layer.borderColor = UIColor.clear.cgColor
    self.contentView.layer.masksToBounds = true
    
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
    self.layer.shadowRadius = 4.0
    self.layer.shadowOpacity = 0.5
    self.layer.masksToBounds = false
    self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    
    parkPhoto.layer.cornerRadius = 10
  }
  
  func configeureCell(name: String, photo: UIImage) {
    self.parkName.text = name
    self.parkPhoto.image = photo
  }
}
