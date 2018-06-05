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
  let service = Service()
  let screenSize : CGRect = UIScreen.main.bounds
  
//  @IBOutlet weak var nameViewHeight: NSLayoutConstraint!
//  @IBOutlet weak var heartWidth: NSLayoutConstraint!
//  @IBOutlet weak var heartHeight: NSLayoutConstraint!
//  @IBOutlet weak var heartTopConstraint: NSLayoutConstraint!
//  @IBOutlet weak var heartLeadingConstraint: NSLayoutConstraint!
//  @IBOutlet weak var labelBottom: NSLayoutConstraint!
  
  @IBOutlet weak var parkPhoto: UIImageView!
  @IBOutlet weak var parkName: UILabel!
  @IBOutlet weak var favoriteButton: UIButton!
//  @IBOutlet weak var parkNameLeading: NSLayoutConstraint!
  
  @IBAction func favoritePressed(_ sender: UIButton) {
    self.delegate?.favoritePressed(cell: self)
    service.animateButton(sender)
  }
  
  func configeureCell(name: String, photo: UIImage, isFavorite: Bool) {
    self.parkName.text = name
    self.parkPhoto.image = photo
    
//    if screenSize.width > 415 {
//      
//      let padding : CGFloat = 40
//      
//      self.heartTopConstraint.constant = padding
//      self.heartLeadingConstraint.constant = padding
//      self.heartWidth.constant = 45
//      self.heartHeight.constant = 39
//      
//      self.nameViewHeight.constant = 65
//      self.labelBottom.constant = 10
//      parkNameLeading.constant = padding
//      self.parkName.font = UIFont(name: "Ubuntu-Bold", size: 42)
//    }
    
    if isFavorite {
      favoriteButton.setBackgroundImage(UIImage(named: "heartGreen"), for: .normal)
    } else {
      favoriteButton.setBackgroundImage(UIImage(named: "heartGrey"), for: .normal)
    }
  }
}
