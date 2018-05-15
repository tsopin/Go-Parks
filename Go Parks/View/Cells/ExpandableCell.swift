//
//  ExpandableCell.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-14.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit
import ExpandableCell

class StateCell: ExpandableCell {
  static let ID = "StateCell"
  
  @IBOutlet weak var stateNameLabel: UILabel!
  @IBOutlet weak var stateFlagImage: UIImageView!
  
  func configeureCell(stateName: String, stateFlag: UIImage) {
    self.stateNameLabel.text = stateName
    self.stateFlagImage.image = stateFlag
  }
  
}

class ParkCell: UITableViewCell {
  static let ID = "ParkCell"
  
  @IBOutlet weak var parkNameLabel: UILabel!
  
  func configeureCell(parkName: String) {
    self.parkNameLabel.text = parkName
  }
  
}

