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
  
  func configeureCell(stateName: String, stateFlag: UIImage) {
    
    self.stateFlagImage.layer.cornerRadius = 10
    self.stateFlagImage.layer.masksToBounds = true
    self.stateNameLabel.text = stateName
    self.stateFlagImage.image = stateFlag
  }
  
}


