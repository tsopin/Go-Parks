//
//  StateCell.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-14.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class StateCell: UITableViewCell {
  static let ID = "StateCell"
  
  @IBOutlet weak var stateNameLabel: UILabel!
  @IBOutlet weak var stateFlagImage: UIImageView!
  @IBOutlet weak var numberOfParks: UILabel!
  
  func configeureCell(stateName: String, stateFlag: UIImage, parksCount: String) {
    
    self.stateFlagImage.layer.borderColor = UIColor(rgb: 0xEBEBEB).cgColor
    self.stateFlagImage.layer.borderWidth = 1
    self.stateFlagImage.layer.cornerRadius = 10
    self.stateFlagImage.layer.masksToBounds = true
    self.stateNameLabel.text = stateName
    self.stateFlagImage.image = stateFlag
    self.numberOfParks.text = parksCount
  }
}


