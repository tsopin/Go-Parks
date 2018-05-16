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
  
  
  func configeureCell(name: String, photo: UIImage) {
    self.parkName.text = name
    self.parkPhoto.image = photo
  }
}
