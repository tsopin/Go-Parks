//
//  CampgroundDescriptionVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-10-08.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class CampgroundDescriptionVC: UIViewController {
  
  @IBOutlet weak var campgroundNameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UITextView!
  @IBOutlet weak var regulationLabel: UITextView!
  @IBOutlet weak var trashLabel: UILabel!
  @IBOutlet weak var toiletsLabel: UILabel!
  @IBOutlet weak var internetLabel: UILabel!
  @IBOutlet weak var showersLabel: UILabel!
  @IBOutlet weak var portableWaterLabel: UILabel!
  @IBOutlet weak var firewoodLabel: UILabel!
  @IBOutlet weak var iceLabel: UILabel!
  @IBOutlet weak var wheelchairDescription: UITextView!
  @IBOutlet weak var firestoveDescription: UITextView!
  @IBOutlet weak var rvDescription: UITextView!
  @IBOutlet weak var addInfoLabel: UITextView!
  
  var data: CampgroundData?
 
  override func viewDidLoad() {
        super.viewDidLoad()
    setUpUI()
    }
  
 func setUpUI() {
  
  campgroundNameLabel.text = data?.name
  descriptionLabel.text = data?.description
  regulationLabel.text = data?.regulationsOverview
  trashLabel.text = data?.amenities?.trashRecyclingCollection
  
  var toilets = String()
  for i in (data?.amenities?.toilets)! {
    toilets.append(" \(i)")
  }
  
  var showers = String()
  if (data?.amenities?.showers?.count)! > 0 {
  for i in (data?.amenities?.showers)! {
    showers.append(" \(i)")
    }
  } else {
    showers = "Not available"
  }
  
  toiletsLabel.text = toilets
  internetLabel.text = "\(data?.amenities?.internetConnectivity ?? false)"
  showersLabel.text = showers
  
  var portableWater = String()
  if (data?.amenities?.potableWater?.count)! > 0 {
  for i in (data?.amenities?.potableWater)! {
    portableWater.append(" \(i)")
    }
  } else {
    portableWater = "Not available"
  }
  
  portableWaterLabel.text = portableWater
  firewoodLabel.text = "\(data?.amenities?.firewoodForSale ?? false))"
  
  wheelchairDescription.text = data?.accessibility?.wheelchairAccess
  firestoveDescription.text = data?.accessibility?.fireStovePolicy
  rvDescription.text = data?.accessibility?.rvInfo
  
  let addInfo = "\(data?.accessibility?.additionalInfo ?? ""). \(data?.accessibility?.adaInfo ?? "") "
  addInfoLabel.text = addInfo
  }

}
