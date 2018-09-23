//
//  AlertCell.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-21.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

protocol AlertCellDelegate {
  func openAlertUrl(cell: AlertCell)
}

class AlertCell: UITableViewCell {
  
  static let ID = "AlertCell"
  var delegate: AlertCellDelegate?
  
  @IBOutlet weak var alertCategoryIcon: UIImageView!
  @IBOutlet weak var alertTitle: UILabel!
  @IBOutlet weak var alertDescription: UITextView!
  @IBOutlet weak var moreInfoButton: UIButton!
  @IBOutlet weak var alertCellView: UIView!
  @IBOutlet weak var blurView: UIVisualEffectView!
  @IBOutlet weak var viewView: UIView!
  @IBOutlet weak var blurSubview: UIView!
  @IBOutlet weak var moreHeightConstraint: NSLayoutConstraint!
  
  @IBAction func alertUrlPressed(_ sender: UIButton) {
    delegate?.openAlertUrl(cell: self)
  }
  
  func configureCell(category: String, title: String, description: String, url: String?) {
    
    self.alertDescription.textContainer.lineFragmentPadding = 0
    self.alertDescription.textContainerInset = .zero
    
    self.viewView.layer.shadowColor = UIColor.lightGray.cgColor
    self.viewView.layer.shadowOpacity = 1
    self.viewView.layer.shadowOffset = CGSize(width: 1, height: 1)
    self.viewView.layer.shadowRadius = 4
   
    self.alertTitle.text = title
    self.alertDescription.text = description
    
    if category != "" {
      self.alertCategoryIcon.image = UIImage(named: category)
    } else {
      self.alertCategoryIcon.image = UIImage(named: "Caution")
    }
    
    self.alertCellView.layer.cornerRadius = 14
    self.alertCellView.layer.masksToBounds = true
    
    if url == "" {
      self.moreInfoButton.isHidden = true
      self.moreHeightConstraint.constant = 5
    } else {
      self.moreInfoButton.isHidden = false
      self.moreHeightConstraint.constant = 30
    }

  }

}

