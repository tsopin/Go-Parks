//
//  CampgroundCell.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-10-08.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class CampgroundCell: UITableViewCell {

  @IBOutlet weak var campgroundNameLabel: UILabel!
  
  @IBOutlet weak var totalSitesLabel: UILabel!
  @IBOutlet weak var rvSitesLabel: UILabel!
  
  @IBOutlet weak var tentSitesLabel: UILabel!
  
  
  
  
  
  @IBOutlet weak var directionButtonPressed: UIButton!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func configureCell(name: String, totalSties: Int, rvSites: Int, tentSites: Int) {
    self.campgroundNameLabel.text = name
    self.totalSitesLabel.text = "Total Sites \(totalSties)"
    self.rvSitesLabel.text = "\(rvSites)"
    self.tentSitesLabel.text = "\(tentSites)"
  }

}
